import 'package:dart_amqp/dart_amqp.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authenticator.freezed.dart';

part 'authenticator.g.dart';

part 'authenticator.mapper.dart';

/// AMQP Authenticator config.
@freezed
@MappableClass()
interface class AmqpAuthenticatorConfiguration
    with
        AmqpAuthenticatorConfigurationMappable,
        _$AmqpAuthenticatorConfiguration {
  const AmqpAuthenticatorConfiguration._();

  const factory AmqpAuthenticatorConfiguration.plain({
    /// Username to use when authenticating to the server.
    @Default('guest') //
    String username,

    /// Password to use when authenticating to the server.
    @Default('guest') //
    String password,
  }) = _AmqpAuthenticatorConfigurationAmqp;

  Authenticator get authenticator => switch (this) {
        _ => throw UnimplementedError("Unimplemented AMQP Authenticator."),
      };

  factory AmqpAuthenticatorConfiguration.fromJson(Map<String, dynamic> json) =>
      _$AmqpAuthenticatorConfigurationFromJson(json);
}
