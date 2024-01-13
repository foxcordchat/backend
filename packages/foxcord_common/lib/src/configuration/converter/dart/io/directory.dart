import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

/// Json converter for Dart IO Directory.
class DartIODirectoryConverter extends JsonConverter<Directory, String> {
  const DartIODirectoryConverter();

  @override
  Directory fromJson(String json) => Directory(json);

  @override
  String toJson(Directory object) => object.path;
}
