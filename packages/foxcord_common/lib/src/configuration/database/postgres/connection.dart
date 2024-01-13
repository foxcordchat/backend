import 'package:dart_mappable/dart_mappable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:postgres/postgres.dart';

part 'connection.freezed.dart';
part 'connection.g.dart';
part 'connection.mapper.dart';

/// Postgres connection configuration.
@freezed
@MappableClass()
interface class PostgresDatabaseConnectionConfiguration
    with
        PostgresDatabaseConnectionConfigurationMappable,
        _$PostgresDatabaseConnectionConfiguration {
  const PostgresDatabaseConnectionConfiguration._();

  const factory PostgresDatabaseConnectionConfiguration({
    /// Application name of this connection.
    String? applicationName,

    /// Timezone of this connection for date operations.
    String? timeZone,

    /// SSL mode of this connection.
    SslMode? sslMode,

    /// Replication mode of this connection.
    ReplicationMode? replicationMode,

    /// Connection timeout.
    Duration? connectTimeout,

    /// Connection query timeout.
    Duration? queryTimeout,

    /// Connection query mode.
    QueryMode? queryMode,
  }) = _PostgresDatabaseConnectionConfiguration;

  /// Postgres database connection settings based on this configuration.
  ConnectionSettings get connectionSettings => ConnectionSettings(
        applicationName: applicationName,
        timeZone: timeZone,
        sslMode: sslMode,
        replicationMode: replicationMode,
        connectTimeout: connectTimeout,
        queryTimeout: queryTimeout,
        queryMode: queryMode,
      );

  factory PostgresDatabaseConnectionConfiguration.fromJson(
          Map<String, dynamic> json) =>
      _$PostgresDatabaseConnectionConfigurationFromJson(json);
}
