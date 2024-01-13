import 'dart:convert';
import 'dart:typed_data';

import 'package:dargon2/dargon2.dart';
import 'package:injectable/injectable.dart';

/// Service for password hashing and checking.
@lazySingleton
final class PasswordService {
  /// Salt to use when hashing password.
  final Salt _salt = Salt.newSalt();

  /// Hash password.
  Future<Uint8List> hashPassword(String password) async {
    final DArgon2Result result =
        await argon2.hashPasswordString(password, salt: _salt);

    return Uint8List.fromList(result.encodedBytes);
  }

  /// Verify password validity.
  Future<bool> checkPasswordMatch(
    String rawPassword,
    Uint8List encodedHash,
  ) async {
    final Uint8List password = utf8.encode(rawPassword);
    try {
      return await argon2.verifyHashBytes(password, encodedHash);
    } on DArgon2Exception {
      return false;
    }
  }
}
