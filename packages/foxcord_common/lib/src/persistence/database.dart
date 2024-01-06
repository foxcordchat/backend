import 'package:drift/drift.dart';
import 'package:foxid/foxid.dart';
import 'package:injectable/injectable.dart';

import '../configuration/database/database.dart';
import 'converter/foxid.dart';
import 'table/user.dart';

part 'database.g.dart';

@lazySingleton
@DriftDatabase(tables: [User])
class Database extends _$Database {
  Database(super.queryExecutor);

  @factoryMethod
  factory Database.fromConfiguration(DatabaseConfiguration configuration) =>
      Database(configuration.queryExecutor);

  @override
  int get schemaVersion => 1;

  @disposeMethod
  @override
  Future<void> close() => super.close();

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator migrator) => migrator.createAll(),
        onUpgrade: (Migrator migrator, int from, int to) =>
            throw UnimplementedError(),
      );
}
