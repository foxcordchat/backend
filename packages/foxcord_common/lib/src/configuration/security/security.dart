import 'package:dart_mappable/dart_mappable.dart';
import 'package:foxcord_common/src/configuration/security/password/password.dart';
import 'package:foxcord_common/src/configuration/security/token/token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'security.freezed.dart';
part 'security.g.dart';
part 'security.mapper.dart';

/// Security features configuration.
@freezed
@MappableClass()
interface class SecurityConfiguration
    with SecurityConfigurationMappable, _$SecurityConfiguration {
  const SecurityConfiguration._();

  const factory SecurityConfiguration({
    /// Token configuration.
    @Default(TokenConfiguration()) TokenConfiguration token,

    /// Password configuration.
    @Default(PasswordConfiguration()) PasswordConfiguration password,
  }) = _SecurityConfiguration;

  factory SecurityConfiguration.fromJson(Map<String, dynamic> json) =>
      _$SecurityConfigurationFromJson(json);
}
