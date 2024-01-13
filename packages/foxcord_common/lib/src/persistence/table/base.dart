import 'package:drift/drift.dart';
import 'package:foxid/foxid.dart';

import '../converter/foxid.dart';

/// Base model.
abstract class BaseTable extends Table {
  /// An ID.
  TextColumn get id => text()
      .map(FOxIDConverter())
      .clientDefault(() => FOxID.generate().toJson())();

  @override
  Set<Column> get primaryKey => {id};
}
