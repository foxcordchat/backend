import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

class DartIOFileConverter extends JsonConverter<File, String> {
  const DartIOFileConverter();

  @override
  File fromJson(String json) => File(json);

  @override
  String toJson(File object) => object.path;
}
