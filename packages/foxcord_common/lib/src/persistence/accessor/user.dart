import 'package:drift/drift.dart';
import 'package:foxid/foxid.dart';
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

  /// Find user by its username.
  Future<UserData?> findByUsername(String username) async {
    final query = select(user)
      ..where(
        (table) => table.username.equals(username),
      );

    return await query.getSingleOrNull();
  }

  /// Find user by its id.
  Future<UserData?> findById(FOxID id) async {
    final query = select(user)
      ..where(
        (table) => table.id.equals(id.toJson()),
      );

    return await query.getSingleOrNull();
  }

  /// Find user by its email.
  Future<UserData?> findByEmail(String email) async {
    final query = select(user)
      ..where(
        (table) => table.email.equals(email),
      );

    return await query.getSingleOrNull();
  }
}
