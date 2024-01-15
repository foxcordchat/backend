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
    hashLength: _hashLength,
  );

  /// Generate salt.
  List<int> generateSalt() => List.generate(
        _saltLength,
        (_) => UintMeta.uint8.random(_random),
      );

  /// Hash password.
  Future<Uint8List> hashPassword(String password) async {
    final List<int> salt = generateSalt();

    final SecretKey result = await _algorithm.deriveKeyFromPassword(
      password: password,
      nonce: salt,
    );

    final List<int> hashBytes = await result.extractBytes();

    final Pickle pickle = Pickle.empty()
      // 0 == argon2id
      ..writeUInt32(0)
      // salt length
      ..writeUInt32(salt.length)
      ..writeBytes(salt, salt.length)
      // hash length
      ..writeUInt32(hashBytes.length)
      ..writeBytes(hashBytes, hashBytes.length);

    return pickle.usedHeader;
  }

  /// Verify password validity.
  Future<bool> checkPasswordMatch(
    String password,
    Uint8List encodedHash,
  ) async {
    final PickleIterator iterator =
        Pickle.fromUint8List(encodedHash).createIterator();

    final (_, salt, hash) = (
      iterator.readUInt32(),
      iterator.readBytes(
        iterator.readUInt32(),
      ),
      iterator.readBytes(
        iterator.readUInt32(),
      ),
    );

    final result =
        await _algorithm.deriveKeyFromPassword(password: password, nonce: salt);

    final resultBytes = await result.extractBytes();

    return constantTimeBytesEquality.equals(resultBytes, hash);
  }
}
