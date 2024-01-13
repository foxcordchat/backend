import 'package:foxcord_common/foxcord_common.dart';
import 'package:foxcord_common/src/service/user/password.dart';
import 'package:injectable/injectable.dart';

/// Service for managing users.
@lazySingleton
final class UserService {
  UserService(
    UserAccessor userAccessor,
    PasswordService passwordService,
  );
}
