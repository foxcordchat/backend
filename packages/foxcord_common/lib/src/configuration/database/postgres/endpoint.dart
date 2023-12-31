import 'package:dart_mappable/dart_mappable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:postgres/postgres.dart';

part 'endpoint.freezed.dart';
part 'endpoint.g.dart';
part 'endpoint.mapper.dart';

/// Database endpoint configuration.
@freezed
@MappableClass()
interface class PostgresDatabaseEndpointConfiguration
    with
        PostgresDatabaseEndpointConfigurationMappable,
        _$PostgresDatabaseEndpointConfiguration {
  /// Default postgres port.
  static const int _defaultPort = 5432;

  const PostgresDatabaseEndpointConfiguration._();

  const factory PostgresDatabaseEndpointConfiguration({
    /// Database host.
    required String host,

    /// Database port.
    @Default(PostgresDatabaseEndpointConfiguration._defaultPort) int port,

    /// Database name.
    required String database,

    /// Database username.
    String? username,

    /// Database password.
    String? password,
  }) = _PostgresDatabaseEndpointConfiguration;

  /// Postgres database endpoint based on this configuration.
  Endpoint get endpoint => Endpoint(
        host: host,
        port: port,
        database: database,
        username: username,
        password: password,
      );

  factory PostgresDatabaseEndpointConfiguration.fromJson(Map<String, dynamic> json) =>
      _$PostgresDatabaseEndpointConfigurationFromJson(json);
}
