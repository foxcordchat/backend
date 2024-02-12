import 'package:dart_mappable/dart_mappable.dart';
import 'package:foxcord_common/src/configuration/security/password/hash/hash.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'password.freezed.dart';
part 'password.g.dart';
part 'password.mapper.dart';

/// Password related configuration.
@freezed
@MappableClass()
interface class PasswordConfiguration
    with PasswordConfigurationMappable, _$PasswordConfiguration {
  const PasswordConfiguration._();

  const factory PasswordConfiguration({
    /// Password hashing configuration.
    @Default(PasswordHashConfiguration.argon2id())
    PasswordHashConfiguration hash,
  }) = _PasswordConfiguration;

  factory PasswordConfiguration.fromJson(Map<String, dynamic> json) =>
      _$PasswordConfigurationFromJson(json);
}
