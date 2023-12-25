import 'package:dart_mappable/dart_mappable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:postgres/postgres_v3_experimental.dart';

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

  /// Default SSL requirement.
  static const bool _defaultRequireSsl = false;

  /// Send cleartext password by default.
  static const bool _defaultAllowCleartextPassword = false;

  const DatabaseEndpointConfiguration._();

  const factory DatabaseEndpointConfiguration({
    /// Database name.
    required String database,

    /// Database host.
    required String host,

    /// Database port.
    @Default(DatabaseEndpointConfiguration._defaultPort) int port,

    /// Database username.
    String? username,

    /// Database password.
    String? password,

    /// Use SSL for database connection.
    @Default(DatabaseEndpointConfiguration._defaultRequireSsl) bool requireSsl,

    /// Allow the database password to be used in cleartext. NOT SAFE!!!
    @Default(DatabaseEndpointConfiguration._defaultAllowCleartextPassword)
    bool allowCleartextPassword,
  }) = _DatabaseEndpointConfiguration;

  /// Postgres database endpoint based on this configuration.
  PgEndpoint toPgEndpoint() => PgEndpoint(
        host: host,
        port: port,
        database: database,
        username: username,
        password: password,
        requireSsl: requireSsl,
      );

  factory DatabaseEndpointConfiguration.fromJson(Map<String, dynamic> json) =>
      _$DatabaseEndpointConfigurationFromJson(json);
}
