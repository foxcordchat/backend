/// Extension for creating bit flags from enum options.
extension _BitFlagEnum on Enum {
  int get flag => 1 << index;
}

/// Class for managing bit fields represented as integers.
base class BitField<BitType extends Enum> {
  /// Set of bit flags.
  int value;

  BitField([this.value = 0]);

  /// Add a bit flag to the field.
  void add(BitType bit) => value |= bit.flag;

  /// Remove a bit flag from the field.
  void remove(BitType bit) => value &= ~bit.flag;

  /// Check if a specific bit flag is present in the field.
  bool has(BitType bit) => (value & bit.flag) == bit.flag;

  /// Check if a specific bit flag is missing from the field.
  bool missing(BitType bit) => !has(bit);
}
