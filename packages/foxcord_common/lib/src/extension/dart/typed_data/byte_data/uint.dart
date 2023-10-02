import 'dart:typed_data';

/// Extension that adds missing uint data types.
extension UintByteData on ByteData {
  /// Size of uint24 data type in bytes.
  static const int uint24NumBytes = 3;

  /// Size of uint48 data type in bytes.
  static const int uint48NumBytes = 6;

  /// Returns the bit shift needed to represent different uint's as a set of consecutive uint8.
  static int getShift(int byte, int numBytes, [Endian endian = Endian.big]) =>
      (endian == Endian.little ? byte : numBytes - 1 - byte) * 8;

  /// Sets the [numBytes] bytes starting at the specified [byteOffset] in this object
  /// to the unsigned binary representation of the specified [value],
  /// which must fit in [numBytes] bytes.
  ///
  /// In other words, [value] must be between
  /// 0 and 2<sup>([numBytes] * 8)</sup> - 1, inclusive.
  ///
  /// The [byteOffset] must be non-negative, and
  /// `byteOffset + numBytes` must be less than or equal to the length of this object.
  void setUint(int byteOffset, int value, int numBytes, [Endian endian = Endian.big]) {
    for (int byte = 0; byte < numBytes; byte++) {
      int shift = getShift(byte, numBytes, endian);
      int byteValue = (value >> shift) & 0xFF;
      setUint8(byteOffset + byte, byteValue);
    }
  }

  /// Returns the positive integer represented by the [numBytes] bytes starting
  /// at the specified [byteOffset] in this object, in unsigned binary
  /// form.
  ///
  /// The return value will be between 0 and  2<sup>([numBytes] * 8)</sup> - 1, inclusive.
  ///
  /// The [byteOffset] must be non-negative, and
  /// `byteOffset + numBytes` must be less than or equal to the length of this object.
  int getUint(int byteOffset, int numBytes, [Endian endian = Endian.big]) {
    int result = 0;
    for (int byte = 0; byte < numBytes; byte++) {
      int shift = getShift(byte, numBytes, endian);
      int byteValue = getUint8(byteOffset + byte);
      result |= (byteValue << shift);
    }
    return result;
  }

  /// Returns the positive integer represented by the three bytes starting
  /// at the specified [byteOffset] in this object, in unsigned binary
  /// form.
  ///
  /// The return value will be between 0 and  2<sup>24</sup> - 1, inclusive.
  ///
  /// The [byteOffset] must be non-negative, and
  /// `byteOffset + 3` must be less than or equal to the length of this object.
  int getUint24(int byteOffset, [Endian endian = Endian.big]) => getUint(byteOffset, uint24NumBytes, endian);

  /// Sets the three bytes starting at the specified [byteOffset] in this object
  /// to the unsigned binary representation of the specified [value],
  /// which must fit in three bytes.
  ///
  /// In other words, [value] must be between
  /// 0 and 2<sup>24</sup> - 1, inclusive.
  ///
  /// The [byteOffset] must be non-negative, and
  /// `byteOffset + 3` must be less than or equal to the length of this object.
  void setUint24(int byteOffset, int value, [Endian endian = Endian.big]) =>
      setUint(byteOffset, value, uint24NumBytes, endian);

  /// Returns the positive integer represented by the six bytes starting
  /// at the specified [byteOffset] in this object, in unsigned binary
  /// form.
  ///
  /// The return value will be between 0 and  2<sup>48</sup> - 1, inclusive.
  ///
  /// The [byteOffset] must be non-negative, and
  /// `byteOffset + 6` must be less than or equal to the length of this object.
  int getUint48(int byteOffset, [Endian endian = Endian.big]) => getUint(byteOffset, uint48NumBytes, endian);

  /// Sets the six bytes starting at the specified [byteOffset] in this object
  /// to the unsigned binary representation of the specified [value],
  /// which must fit in six bytes.
  ///
  /// In other words, [value] must be between
  /// 0 and 2<sup>48</sup> - 1, inclusive.
  ///
  /// The [byteOffset] must be non-negative, and
  /// `byteOffset + 6` must be less than or equal to the length of this object.
  void setUint48(int byteOffset, int value, [Endian endian = Endian.big]) =>
      setUint(byteOffset, value, uint48NumBytes, endian);
}
