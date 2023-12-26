import 'package:dart_mappable/dart_mappable.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'connection.dart';
import 'endpoint.dart';

part 'database.freezed.dart';
part 'database.g.dart';
part 'database.mapper.dart';

/// Database connection configuration.
@freezed
@MappableClass()
interface class DatabaseConfiguration
    with DatabaseConfigurationMappable, _$DatabaseConfiguration {
  /// Log database queries by default.
  static const _defaultLogStatements = false;

  /// Enable migrations by default.
  static const _defaultEnableMigrations = true;

  const DatabaseConfiguration._();

  const factory DatabaseConfiguration({
    /// Database endpoint.
    required DatabaseEndpointConfiguration endpoint,

    /// Database connection.
    DatabaseConnectionConfiguration? connection,

    /// Log database queries.
    @Default(DatabaseConfiguration._defaultLogStatements) bool logStatements,

    /// Enable database migrations.
    @Default(DatabaseConfiguration._defaultEnableMigrations)
    bool enableMigrations,
  }) = _DatabaseConfiguration;

  /// Postgres database driver with this configuration.
  PgDatabase toPgDatabase() => PgDatabase(
        endpoint: endpoint.toPgEndpoint(),
        settings: connection?.toPgConnection(),
        logStatements: logStatements,
        enableMigrations: enableMigrations,
      );

  factory DatabaseConfiguration.fromJson(Map<String, dynamic> json) =>
      _$DatabaseConfigurationFromJson(json);
}
