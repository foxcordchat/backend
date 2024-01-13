import 'package:dartfield/dartfield.dart';
import 'package:drift/drift.dart';

/// Converts BitField to Drift's BigInt.
class BitFieldConverter<BitType extends Enum>
    extends TypeConverter<BitField<BitType>, BigInt> {
  const BitFieldConverter();

  @override
  BitField<BitType> fromSql(BigInt fromDb) => BitField(fromDb);

  @override
  BigInt toSql(BitField<BitType> value) => value.value;
}
