import 'package:dart_mappable/dart_mappable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dart_amqp/dart_amqp.dart';

part 'amqp.freezed.dart';

part 'amqp.g.dart';

part 'amqp.mapper.dart';

/// AMQP connection options.
@freezed
@MappableClass()
interface class AMQPConfiguration with _$AMQPConfiguration {
  /// Default virtual host.
  static const String defaultVirtualHost = "/";

  /// Default user name.
  static const String defaultUsername = "guest";

  /// Default password.
  static const String defaultPassword = "guest";

  const AMQPConfiguration._();

  const factory AMQPConfiguration({
    /// Host to connect to.
    required String host,

    /// Port to connect on.
    required int port,

    /// Virtual host to access during this connection.
    @Default(AMQPConfiguration.defaultVirtualHost) String virtualHost,

    /// Username to use when authenticating to the server.
    @Default(AMQPConfiguration.defaultUsername) String username,

    /// Password to use when authenticating to the server.
    @Default(AMQPConfiguration.defaultPassword) String password,
  }) = _AMQPConfiguration;

  /// Returns a authenticator based on this configuration.
  Authenticator get authenticator => PlainAuthenticator(username, password);

  /// Returns AMQP connection settings based on this configuration.
  ConnectionSettings toConnectionSettings() => ConnectionSettings(
      host: host,
      port: port,
      virtualHost: virtualHost,
      authProvider: authenticator);

  factory AMQPConfiguration.fromJson(Map<String, dynamic> json) =>
      _$AMQPConfigurationFromJson(json);
}
