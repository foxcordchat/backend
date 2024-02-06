import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:cryptography/helpers.dart';
import 'package:injectable/injectable.dart';
import 'package:protobuf/protobuf.dart';

import '../../../gen/proto/foxcord/service/authentication/token/v1/token.pb.dart';
import '../../configuration/security/token/token.dart';

/// Service for generating and verifying tokens.
@lazySingleton
final class TokenService {
  /// HMAC used for password matching.
  static final Hmac _hmac = Hmac.blake2s();

  /// Codec used for token encoding.
  final Codec<List<int>, String> _codec;

  /// Token configuration.
  final TokenConfiguration _configuration;

  TokenService(this._configuration) : _codec = _configuration.codec.codec;

  /// Generate token.
  Future<String> generate(
    Uint8List payload,
    Uint8List secretKey, {
    DateTime? timestamp,
  }) async {
    timestamp ??= DateTime.now();

    final Token token = Token(
      payload: payload,
      timestamp: timestamp.toUtc().millisecondsSinceEpoch ~/
          Duration.millisecondsPerSecond,
    );

    final Mac calculatedMac = await _hmac.calculateMac(
      token.writeToBuffer(),
      secretKey: SecretKey(secretKey),
    );

    token.signature = calculatedMac.bytes;

    return _codec.encode(token.writeToBuffer());
  }

  /// Decode token from string.
  Token decodeToken(String token) => Token.fromBuffer(_codec.decode(token));

  /// Check if token expired.
  bool _isTokenExpired(Token token, DateTime validAfter) {
    final DateTime tokenTimestamp = DateTime.fromMillisecondsSinceEpoch(
        token.timestamp * Duration.millisecondsPerSecond);

    return tokenTimestamp.isBefore(validAfter);
  }

  /// Verify token validity.
  Future<bool> verify(
    String token,
    Uint8List secretKey, [
    DateTime? validSince,
  ]) async {
    final tokenData = decodeToken(token);

    if (validSince != null && _isTokenExpired(tokenData, validSince)) {
      return false;
    }

    final Token tokenDataUnsigned = tokenData.deepCopy()..clearSignature();

    final Mac calculatedMac = await _hmac.calculateMac(
      tokenDataUnsigned.writeToBuffer(),
      secretKey: SecretKey(secretKey),
    );

    return constantTimeBytesEquality.equals(
        tokenData.signature, calculatedMac.bytes);
  }
}
