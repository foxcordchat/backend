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

  /// Default token configuration.
  static const TokenConfiguration _tokenConfigurationDefault =
      TokenConfiguration();

  /// Default password configuration
  static const PasswordConfiguration _passwordConfigurationDefault =
      PasswordConfiguration();

  const factory SecurityConfiguration({
    /// Token configuration.
    @Default(SecurityConfiguration._tokenConfigurationDefault)
    TokenConfiguration token,

    /// Password configuration.
    @Default(SecurityConfiguration._passwordConfigurationDefault)
    PasswordConfiguration password,
  }) = _SecurityConfiguration;

  factory SecurityConfiguration.fromJson(Map<String, dynamic> json) =>
      _$SecurityConfigurationFromJson(json);
}
