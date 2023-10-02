/// Extension for creating bit flags from enum options.
extension BitFlag on Enum {
  /// Flag of this bit.
  BigInt get flag => BigInt.one << index;
}
