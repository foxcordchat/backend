import 'package:foxcord_common/src/structure/type/bitfield.dart';
import 'package:test/test.dart';

enum Bits { first, second, third }

Future<void> main() async {
  group(BitField<Bits>, () {
    test('should add bit', () {
      final BitField<Bits> bitField = BitField<Bits>.empty();

      bitField.add(Bits.first);

      expect(bitField.value, BigInt.one);
    });

    test('should remove bit', () {
      final BitField<Bits> bitField = BitField<Bits>.fromInt(3);

      bitField.remove(Bits.first);

      expect(bitField.value, BigInt.two);
    });

    test('should detect if bit exists', () {
      final BitField<Bits> bitField = BitField<Bits>.fromInt(3);

      final bool bitExists = bitField.has(Bits.first);

      expect(bitExists, true);
    });

    test('should detect if bit missing', () {
      final BitField<Bits> bitField = BitField<Bits>.fromInt(5);

      final bool bitMissing = bitField.missing(Bits.second);

      expect(bitMissing, true);
    });
  });
}
