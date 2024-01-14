import 'dart:convert';

import 'package:base85/base85.dart';
import 'package:chromium_pickle/chromium_pickle.dart';
import 'package:cryptography/cryptography.dart';
import 'package:foxid/foxid.dart';
import 'package:injectable/injectable.dart';

import '../../extension/dart/core/date_time.dart';
import '../../persistence/accessor/user.dart';
import '../../persistence/database.dart';

@lazySingleton
final class TokenService {
  static final Codec<List<int>, String> _codec = Base85Codec(Alphabets.z85);
  static final Hmac _hmac = Hmac.blake2s();

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
}
