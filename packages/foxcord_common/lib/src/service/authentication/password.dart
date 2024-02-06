import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:cryptography/helpers.dart';
import 'package:foxid/foxid.dart';
import 'package:injectable/injectable.dart';

import '../../../gen/proto/foxcord/service/authentication/password/v1/password.pb.dart';
import '../../configuration/security/password/hash/hash.dart';
import '../../configuration/security/password/password.dart';

/// Service for password hashing and checking.
@lazySingleton
final class PasswordService {
  /// Salt length.
  static const int _saltLength = 32;

  /// Random values generator.
  static final Random _random = Random.secure();

  /// Password hashing configuration.
  final PasswordConfiguration configuration;

  /// Password hashing algorithm.
  final KdfAlgorithm _algorithm;

  PasswordService(this.configuration)
      : _algorithm = configuration.hash.kdfAlgorithm;

  /// Generate salt.
  List<int> generateSalt() => List.generate(
        _saltLength,
        (_) => UintMeta.uint8.random(_random),
      );

  /// Hash password.
  Future<Uint8List> hashPassword(String password) async {
    final List<int> salt = generateSalt();

    final SecretKey derivedKey =
        await _algorithm.deriveKeyFromPassword(password: password, nonce: salt);

    final PasswordHash passwordHash = PasswordHash(
      configuration: configuration.hash.configurationMessage,
      salt: salt,
      hash: await derivedKey.extractBytes(),
    );

    return passwordHash.writeToBuffer();
  }

  /// Verify password validity.
  Future<bool> checkPasswordMatch(
    String password,
    Uint8List encodedHash,
  ) async {
    final PasswordHash passwordHash = PasswordHash.fromBuffer(encodedHash);

    final PasswordHashConfiguration initialConfiguration =
        PasswordHashConfiguration.fromConfigurationMessage(
            passwordHash.configuration);

    final SecretKey derivedKey = await initialConfiguration.kdfAlgorithm
        .deriveKeyFromPassword(password: password, nonce: passwordHash.salt);

    return constantTimeBytesEquality.equals(
      await derivedKey.extractBytes(),
      passwordHash.hash,
    );
  }
}
