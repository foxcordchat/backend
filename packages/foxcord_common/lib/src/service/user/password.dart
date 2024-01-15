import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:chromium_pickle/chromium_pickle.dart';
import 'package:cryptography/cryptography.dart';
import 'package:cryptography/helpers.dart';
import 'package:foxid/foxid.dart';
import 'package:injectable/injectable.dart';

/// Service for password hashing and checking.
@lazySingleton
final class PasswordService {
  /// Salt length.
  static const int _saltLength = 32;

  /// Password hash length.
  static const int _hashLength = 32;

  /// Random values generator.
  static final Random _random = Random.secure();

  /// Password hashing algorithm.
  final KdfAlgorithm _algorithm = Argon2id(
    parallelism: 1,
    memory: 19000,
    iterations: 2,
    hashLength: 32,
  );

  /// Generate salt.
  List<int> generateSalt() => List.generate(
        _saltLength,
        (_) => UintMeta.uint8.random(_random),
      );

  /// Hash password.
  Future<Uint8List> hashPassword(String password) async {
    final Uint8List rawPassword = utf8.encode(password);
    final List<int> salt = generateSalt();

    final SecretKey result = await _algorithm.deriveKey(
      secretKey: SecretKey(rawPassword),
      nonce: salt,
    );

    final List<int> hashBytes = await result.extractBytes();

    final Pickle pickle = Pickle.empty()
      ..writeBytes(salt, _saltLength)
      ..writeBytes(hashBytes, _hashLength);

    return pickle.usedHeader;
  }

  /// Verify password validity.
  Future<bool> checkPasswordMatch(
    String password,
    Uint8List encodedHash,
  ) async {
    final Uint8List rawPassword = utf8.encode(password);

    final PickleIterator iterator =
        Pickle.fromUint8List(encodedHash).createIterator();

    final (salt, hash) = (
      iterator.readBytes(_saltLength),
      iterator.readBytes(_hashLength),
    );

    final result = await _algorithm.deriveKey(
        secretKey: SecretKey(rawPassword), nonce: salt);

    final resultBytes = await result.extractBytes();

    return constantTimeBytesEquality.equals(resultBytes, hash);
  }
}
