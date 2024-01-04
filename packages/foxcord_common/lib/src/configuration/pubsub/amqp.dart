import 'package:dart_amqp/dart_amqp.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'amqp.freezed.dart';
part 'amqp.g.dart';
part 'amqp.mapper.dart';

/// AMQP connection options.
@freezed
@MappableClass()
interface class AMQPConfiguration with AMQPConfigurationMappable, _$AMQPConfiguration {
  /// Default virtual host.
  static const String _defaultVirtualHost = "/";

  /// Default user name.
  static const String _defaultUsername = "guest";

  /// Default password.
  static const String _defaultPassword = "guest";

  /// Default port.
  static const int _defaultPort = 5672;

  const AMQPConfiguration._();

  const factory AMQPConfiguration({
    /// Host to connect to.
    required String host,

    /// Port to connect on.
    @Default(AMQPConfiguration._defaultPort) int port,

    /// Virtual host to access during this connection.
    @Default(AMQPConfiguration._defaultVirtualHost) String virtualHost,

    /// Username to use when authenticating to the server.
    @Default(AMQPConfiguration._defaultUsername) String username,

    /// Password to use when authenticating to the server.
    @Default(AMQPConfiguration._defaultPassword) String password,
  }) = _AMQPConfiguration;

  /// Returns a authenticator based on this configuration.
  Authenticator get authenticator => PlainAuthenticator(username, password);

  /// Returns AMQP connection settings based on this configuration.
  ConnectionSettings toConnectionSettings() => ConnectionSettings(
        host: host,
        port: port,
        virtualHost: virtualHost,
        authProvider: authenticator,
      );

  factory AMQPConfiguration.fromJson(Map<String, dynamic> json) => _$AMQPConfigurationFromJson(json);
}
