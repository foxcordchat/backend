import 'package:drift/drift.dart';

abstract class BaseTable extends Table {
  TextColumn get id => text()();

  @override
  Set<Column> get primaryKey => {id};
}
