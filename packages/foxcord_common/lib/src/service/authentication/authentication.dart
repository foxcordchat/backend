import 'package:foxcord_common/foxcord_common.dart';
import 'package:foxid/foxid.dart';
import 'package:injectable/injectable.dart';

import '../../../gen/proto/foxcord/service/authentication/token/v1/token.pb.dart';

/// Service for authentication.
@lazySingleton
final class AuthenticationService {
  /// User accessor.
  final UserAccessor _userAccessor;

  /// Token service.
  final TokenService _tokenService;

  AuthenticationService(
    this._userAccessor,
    this._tokenService,
  );

  /// Verify user token validity.
  Future<bool> verifyUserToken(String token) async {
    final Token tokenData = _tokenService.decodeToken(token);
    final FOxID userId = FOxID.fromList(tokenData.payload);
    final UserData? userData = await _userAccessor.findById(userId);

    if (userData != null) {
      return _tokenService.verify(
          token, userData.passwordHash, userData.validTokensSince);
    }

    return false;
  }

  /// Generate token for user.
  Future<String> generateUserToken(UserData userData) async =>
      await _tokenService.generate(userData.id.payload, userData.passwordHash);
}
