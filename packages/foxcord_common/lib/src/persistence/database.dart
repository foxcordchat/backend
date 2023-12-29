import 'package:drift/drift.dart';
import 'package:foxid/foxid.dart';

import 'converter/foxid.dart';
import 'table/user.dart';

part 'database.g.dart';

@DriftDatabase(tables: [User])
class Database extends _$Database {
  Database(super.queryExecutor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator migrator) => migrator.createAll(),
        onUpgrade: (Migrator migrator, int from, int to) =>
            throw UnimplementedError(),
      );
}
