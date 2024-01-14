import 'package:injectable/injectable.dart';

import '../../persistence/accessor/user.dart';
import 'password.dart';

/// Service for managing users.
@lazySingleton
final class UserService {
  UserService(
    UserAccessor userAccessor,
    PasswordService passwordService,
  );
}
