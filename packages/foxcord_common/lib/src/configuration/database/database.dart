import 'package:dart_mappable/dart_mappable.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:foxcord_common/src/configuration/database/session.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'endpoint.dart';

part 'database.freezed.dart';
part 'database.g.dart';
part 'database.mapper.dart';

/// Database connection configuration.
@freezed
@MappableClass()
interface class DatabaseConfiguration
    with DatabaseConfigurationMappable, _$DatabaseConfiguration {
  static const defaultLogStatements = false;
  static const defaultEnableMigrations = true;

  const DatabaseConfiguration._();

  const factory DatabaseConfiguration({
    /// Database endpoint.
    required DatabaseEndpointConfiguration endpoint,

    /// Database session.
    DatabaseSessionConfiguration? session,

    /// Log database queries.
    @Default(DatabaseConfiguration.defaultLogStatements) bool logStatements,

    /// Enable database migrations.
    @Default(DatabaseConfiguration.defaultEnableMigrations)
    bool enableMigrations,
  }) = _DatabaseConfiguration;

  /// Postgres database driver with this configuration.
  PgDatabase toPgDatabase() => PgDatabase(
        endpoint: endpoint.toPgEndpoint(),
        sessionSettings: session?.toPgSessionSettings(),
        logStatements: logStatements,
        enableMigrations: enableMigrations,
      );

  factory DatabaseConfiguration.fromJson(Map<String, dynamic> json) =>
      _$DatabaseConfigurationFromJson(json);
}
