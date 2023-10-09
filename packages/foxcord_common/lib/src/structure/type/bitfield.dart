import 'package:foxcord_common/src/extension/dart/core/enum/bitflag.dart';

/// Class for managing bit fields represented as integers.
base class BitField<BitType extends Enum> {
  /// Set of bit flags.
  BigInt value;

  /// Create bit field from bigint.
  BitField(this.value);

  /// Create empty bit field.
  BitField.empty() : value = BigInt.zero;

  /// Create bit field from int.
  BitField.fromInt(int value) : value = BigInt.from(value);

  /// Add a bit flag to the field.
  void add(BitType bit) => value |= bit.flag;

  /// Remove a bit flag from the field.
  void remove(BitType bit) => value &= ~bit.flag;

  /// Check if a specific bit flag is present in the field.
  bool has(BitType bit) => (value & bit.flag) == bit.flag;

  /// Check if a specific bit flag is missing from the field.
  bool missing(BitType bit) => !has(bit);
}
