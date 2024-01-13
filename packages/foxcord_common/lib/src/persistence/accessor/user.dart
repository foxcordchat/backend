import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../database.dart';
import '../table/user.dart';

part 'user.g.dart';

/// Drift data accessor for the User table.
@lazySingleton
@DriftAccessor(tables: [User])
final class UserAccessor extends DatabaseAccessor<Database>
    with _$UserAccessorMixin {
  UserAccessor(super.attachedDatabase);
}
