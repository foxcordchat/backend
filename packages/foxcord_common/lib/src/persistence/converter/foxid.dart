import 'package:drift/drift.dart';
import 'package:foxid/foxid.dart';

class FOxIDConverter extends TypeConverter<FOxID, String> {
  const FOxIDConverter();

  @override
  FOxID fromSql(String fromDb) => FOxID.fromJson(fromDb);

  @override
  String toSql(FOxID value) => value.toJson();
}
