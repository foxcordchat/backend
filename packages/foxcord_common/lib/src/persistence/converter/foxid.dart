import 'package:drift/drift.dart';
import 'package:foxid/foxid.dart';

/// Converts FOxID to Drift's String.
class FOxIDConverter extends TypeConverter<FOxID, String> {
  const FOxIDConverter();

  @override
  FOxID fromSql(String fromDb) => FOxID.fromJson(fromDb);

  @override
  String toSql(FOxID value) => value.toJson();
}
