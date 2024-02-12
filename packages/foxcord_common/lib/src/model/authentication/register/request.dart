import 'package:dart_mappable/dart_mappable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';
import 'package:luthor_annotation/luthor_annotation.dart';

part 'request.freezed.dart';

part 'request.g.dart';

part 'request.mapper.dart';

@luthor
@freezed
@MappableClass()
interface class AuthenticationRegisterRequestDto
    with
        AuthenticationRegisterRequestDtoMappable,
        _$AuthenticationRegisterRequestDto {
  const factory AuthenticationRegisterRequestDto({
    @HasMin(2) @HasMax(32) required String username,
    @HasMin(8) @HasMax(72) required String password,
    @IsEmail() required String email,
    @IsDateTime() required DateTime dateOfBirth,
  }) = _AuthenticationRegisterRequestDto;

  static SchemaValidationResult<AuthenticationRegisterRequestDto> validate(
    Map<String, dynamic> json,
  ) =>
      _$AuthenticationRegisterRequestDtoValidate(json);

  factory AuthenticationRegisterRequestDto.fromJson(
          Map<String, dynamic> json) =>
      _$AuthenticationRegisterRequestDtoFromJson(json);
}
