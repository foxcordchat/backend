import 'package:dart_mappable/dart_mappable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:postgres/postgres.dart';

part 'endpoint.freezed.dart';

part 'endpoint.g.dart';

part 'endpoint.mapper.dart';

/// Postgres endpoint configuration.
@freezed
@MappableClass()
interface class PostgresDatabaseEndpointConfiguration
    with
        PostgresDatabaseEndpointConfigurationMappable,
        _$PostgresDatabaseEndpointConfiguration {
  const PostgresDatabaseEndpointConfiguration._();

  const factory PostgresDatabaseEndpointConfiguration({
    /// Database host.
    @Default('localhost') //
    String host,

    /// Database port.
    @Default(5432) //
    int port,

    /// Database name.
    @Default('foxcord') //
    String database,

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

  factory PostgresDatabaseEndpointConfiguration.fromJson(
          Map<String, dynamic> json) =>
      _$PostgresDatabaseEndpointConfigurationFromJson(json);
}
