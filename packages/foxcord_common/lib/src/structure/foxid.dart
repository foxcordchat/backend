import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:base32/base32.dart';
import 'package:base32/encodings.dart';

import 'package:foxcord_common/src/extension/dart/typed_data/byte_data/uint.dart';

/// Field options of FOxID.
enum FOxIDFieldOptions {
  timestamp(byteOffset: 1, byteSize: 6),
  datacenter(byteOffset: 6, byteSize: 2),
  worker(byteOffset: 8, byteSize: 2),
  counter(byteOffset: 10, byteSize: 3),
  random(byteOffset: 13, byteSize: 3);

  const FOxIDFieldOptions({
    required this.byteOffset,
    required this.byteSize,
  });

  /// Value offset in bytes.
  final int byteOffset;

  /// Value length in bytes.
  final int byteSize;

  /// Max int value in field.
  int get maxValue => pow(2, byteSize * 8).toInt() - 1;
}

/// A class for manipulating FoxCord FOxID's.
class FOxID {
  /// The encoding in which FOxID is represented as a string.
  static const Encoding _stringEncoding = Encoding.crockford;

  /// The byte order used in FOxID.
  static const Endian _endian = Endian.big;

  /// Length of FOxID in bytes.
  static const int _byteLength = 16;

  /// Secure randomness generator.
  static final Random _random = Random.secure();

  /// Counter that increments every time when new id created.
  static int _increment = 0;

  /// Payload of this FOxID.
  late final Uint8List payload;

  /// Creates FOxID with empty payload.
  FOxID.empty() : payload = Uint8List(_byteLength);

  /// Creates FOxID with predefined payload.
  FOxID.fromUint8List(this.payload) {
    if (payload.lengthInBytes != _byteLength) {
      throw FormatException("Invalid FOxID byte length.");
    }
  }

  /// Extracts FOxID from its string representation.
  factory FOxID.fromJson(String json) => FOxID.fromUint8List(
        base32.decode(json, encoding: _stringEncoding),
      );

  /// Generates FOxID with predefined parameters.
  factory FOxID.generate({DateTime? time, int? datacenter, int? worker, int? counter, int? random}) => FOxID.empty()
    ..time = time ?? DateTime.now()
    ..datacenter = datacenter ?? Platform.localHostname.hashCode
    ..worker = worker ?? pid
    ..counter = counter ?? _increment++
    ..random = _random.nextInt(FOxIDFieldOptions.random.maxValue);

  /// Reader/Writer of internal FOxID byte-buffer.
  ByteData get _view => ByteData.view(payload.buffer);

  /// Time when this FOxID generated.
  DateTime get time => DateTime.fromMillisecondsSinceEpoch(timestamp);

  /// Sets the time when this FOxID generated.
  set time(DateTime value) => timestamp = value.millisecondsSinceEpoch;

  /// The number of milliseconds since the start of the epoch.
  int get timestamp => _view.getUint48(FOxIDFieldOptions.timestamp.byteOffset, _endian);

  /// Sets the timestamp of the current FOxID.
  set timestamp(int value) => _view.setUint48(FOxIDFieldOptions.timestamp.byteOffset, value, _endian);

  /// The identifier of the datacenter that created this FOxID.
  int get datacenter => _view.getUint16(FOxIDFieldOptions.datacenter.byteOffset, _endian);

  /// Sets identifier of the datacenter that created this FOxID.
  set datacenter(int value) => _view.setUint16(FOxIDFieldOptions.datacenter.byteOffset, value, _endian);

  /// The identifier of the worker that created this FOxID.
  int get worker => _view.getUint16(FOxIDFieldOptions.worker.byteOffset, _endian);

  /// Sets identifier of the worker that created this FOxID.
  set worker(int value) => _view.setUint16(FOxIDFieldOptions.worker.byteOffset, value, _endian);

  /// Counter that incremented each time when new FOxID is created.
  int get counter => _view.getUint24(FOxIDFieldOptions.counter.byteOffset, _endian);

  /// Sets the value of the counter, which should be incremented each time a new FOxID is created.
  set counter(int value) => _view.setUint24(FOxIDFieldOptions.counter.byteOffset, value, _endian);

  /// Random value obtained at the time of identifier generation.
  int get random => _view.getUint24(FOxIDFieldOptions.random.byteOffset, _endian);

  /// Sets of random value that is normally obtained at the time when identifier is generated.
  set random(int value) => _view.setUint24(FOxIDFieldOptions.random.byteOffset, value, _endian);

  /// Encode this FOxID to string.
  String toJson() => base32.encode(payload, encoding: _stringEncoding);
}
