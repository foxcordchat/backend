import 'package:dart_mappable/dart_mappable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'response.freezed.dart';

part 'response.g.dart';

part 'response.mapper.dart';

@freezed
@MappableClass()
interface class AuthenticationRegisterResponseDto
    with
        AuthenticationRegisterResponseDtoMappable,
        _$AuthenticationRegisterResponseDto {
  const factory AuthenticationRegisterResponseDto.ok({
    required String token,
  }) = _AuthenticationRegisterResponseDtoOk;

  factory AuthenticationRegisterResponseDto.fromJson(
          Map<String, dynamic> json) =>
      _$AuthenticationRegisterResponseDtoFromJson(json);
}
