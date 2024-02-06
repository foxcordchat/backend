import 'package:drift/drift.dart';

import 'base.dart';

/// A user.
abstract class User extends BaseTable {
  /// Username. Must be unique and contain from 2 to 32 characters.
  TextColumn get username => text().withLength(min: 2, max: 32).unique()();

  /// Email. Must have a valid email address.
  TextColumn get email => text().withLength(min: 4, max: 254).unique()();

  /// Hashed password.
  BlobColumn get passwordHash => blob()();

  /// All tokens with a previous issue date are invalid.
  DateTimeColumn get validTokensSince =>
      dateTime().withDefault(currentDateAndTime)();

  /// Date of birth.
  DateTimeColumn get dateOfBirth => dateTime()();
}
