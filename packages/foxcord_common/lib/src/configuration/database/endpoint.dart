import 'package:dart_mappable/dart_mappable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:postgres/postgres.dart';

part 'endpoint.freezed.dart';
part 'endpoint.g.dart';
part 'endpoint.mapper.dart';

/// Database endpoint configuration.
@freezed
@MappableClass()
interface class DatabaseEndpointConfiguration
    with
        DatabaseEndpointConfigurationMappable,
        _$DatabaseEndpointConfiguration {
  /// Default postgres port.
  static const int _defaultPort = 5432;

  const DatabaseEndpointConfiguration._();

  const factory DatabaseEndpointConfiguration({
    /// Database host.
    required String host,

    /// Database port.
    @Default(DatabaseEndpointConfiguration._defaultPort) int port,

    /// Database name.
    required String database,

    /// Database username.
    String? username,

    /// Database password.
    String? password,
  }) = _DatabaseEndpointConfiguration;

  /// Postgres database endpoint based on this configuration.
  Endpoint toPgEndpoint() => Endpoint(
        host: host,
        port: port,
        database: database,
        username: username,
        password: password,
      );

  factory DatabaseEndpointConfiguration.fromJson(Map<String, dynamic> json) =>
      _$DatabaseEndpointConfigurationFromJson(json);
}
