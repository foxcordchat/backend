import 'package:drift/drift.dart';

import 'base.dart';

interface class User extends BaseTable {
  TextColumn get username => text().withLength(min: 2, max: 32).unique()();

  TextColumn get email => text().withLength(min: 4, max: 254).unique()();

  BlobColumn get passwordHash => blob()();
}
