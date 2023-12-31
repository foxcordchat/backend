import 'dart:io';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:drift/backends.dart';
import 'package:drift/native.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../converter/dart/io/file.dart';
import 'postgres/connection.dart';
import 'postgres/endpoint.dart';

part 'database.freezed.dart';
part 'database.g.dart';
part 'database.mapper.dart';

/// Database connection configuration.
@Freezed(unionKey: 'type')
@MappableClass()
interface class DatabaseConfiguration
    with DatabaseConfigurationMappable, _$DatabaseConfiguration {
  /// Log database queries by default.
  static const _defaultLogStatements = false;

  /// Enable migrations by default.
  static const _defaultEnableMigrations = true;

  const DatabaseConfiguration._();

  const factory DatabaseConfiguration.sqlite({
    /// Database file.
    @DartIOFileConverter() required File file,

    /// Log database queries.
    @Default(DatabaseConfiguration._defaultLogStatements) bool logStatements,
  }) = _DatabaseConfigurationSqlite;

  const factory DatabaseConfiguration.postgres({
    /// Database endpoint.
    required PostgresDatabaseEndpointConfiguration endpoint,

    /// Database connection.
    PostgresDatabaseConnectionConfiguration? connection,

    /// Log database queries.
    @Default(DatabaseConfiguration._defaultLogStatements) bool logStatements,

    /// Enable database migrations.
    @Default(DatabaseConfiguration._defaultEnableMigrations)
    bool enableMigrations,
  }) = _DatabaseConfigurationPostgres;

  /// Get query executor from this config
  QueryExecutor get queryExecutor => switch (this) {
        _DatabaseConfigurationSqlite(
          :final file,
          :final logStatements,
        ) =>
          NativeDatabase(
            file,
            logStatements: logStatements,
          ),
        _DatabaseConfigurationPostgres(
          :final endpoint,
          :final connection,
          :final enableMigrations,
          :final logStatements,
        ) =>
          PgDatabase(
            endpoint: endpoint.endpoint,
            settings: connection?.connectionSettings,
            logStatements: logStatements,
            enableMigrations: enableMigrations,
          ),
        _ => throw RangeError("Unknown database impl"),
      };

  factory DatabaseConfiguration.fromJson(Map<String, dynamic> json) =>
      _$DatabaseConfigurationFromJson(json);
}
