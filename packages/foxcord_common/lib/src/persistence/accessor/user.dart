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

  Future<UserData> findByUsername(String username) async {
    final query = select(user)
      ..where(
        (table) => table.username.equals(username),
      );

    return await query.getSingle();
  }

  Future<UserData> findById(dynamic id) async {
    final query = select(user)
      ..where(
        (table) => table.id.equals(id is FOxID ? id.toJson() : id.toString()),
      );

    return await query.getSingle();
  }
}
