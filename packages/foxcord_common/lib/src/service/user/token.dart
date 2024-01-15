import 'dart:convert';
import 'dart:typed_data';

import 'package:base85/base85.dart';
import 'package:chromium_pickle/chromium_pickle.dart';
import 'package:cryptography/cryptography.dart';
import 'package:cryptography/helpers.dart';
import 'package:foxid/foxid.dart';
import 'package:injectable/injectable.dart';

import '../../extension/dart/core/date_time.dart';
import '../../persistence/accessor/user.dart';
import '../../persistence/database.dart';

@lazySingleton
final class TokenService {
  static final Codec<List<int>, String> _codec = Base85Codec(Alphabets.z85);
  static final Hmac _hmac = Hmac.blake2s();

  final UserAccessor userAccessor;

  TokenService(this.userAccessor);

  Future<String> generate(
    UserData user, {
    DateTime? creationTime,
  }) async {
    creationTime ??= DateTime.now();

    final Pickle pickle = Pickle.empty()
      ..writeBytes(user.id.payload, FOxID.byteLength)
      ..writeUInt32(creationTime.toUtc().secondsSinceEpoch);

    final Mac signature = await _hmac.calculateMac(
      pickle.usedPayload,
      secretKey: SecretKey(user.passwordHash),
    );

    pickle.writeBytes(signature.bytes, _hmac.macLength);

    return _codec.encode(pickle.usedHeader);
  }

  Future<bool> verify(String token) async {
    try {
      final Uint8List tokenData = Uint8List.fromList(_codec.decode(token));

      final Pickle pickle = Pickle.fromUint8List(tokenData);
      final PickleIterator iterator = pickle.createIterator();

      final (id, timestamp, signature) = (
        FOxID.fromUint8List(
          iterator.readBytes(FOxID.byteLength),
        ),
        DateTime.fromMillisecondsSinceEpoch(
          iterator.readUInt32() * Duration.millisecondsPerSecond,
          isUtc: true,
        ),
        iterator.readBytes(_hmac.macLength),
      );

      final UserData user = await userAccessor.findById(id);

      if (timestamp.isBefore(user.validTokensSince)) {
        return false;
      }

      final Mac expectedSignature = await _hmac.calculateMac(
        pickle.usedPayload.sublist(0, pickle.payloadSize - _hmac.macLength),
        secretKey: SecretKey(user.passwordHash),
      );

      return constantTimeBytesEquality.equals(
        expectedSignature.bytes,
        signature,
      );
    } catch (_) {
      return false;
    }
  }
}
