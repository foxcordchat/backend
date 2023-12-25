import 'package:dart_mappable/dart_mappable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:postgres/postgres.dart';
import 'package:postgres/postgres_v3_experimental.dart';

part 'session.freezed.dart';
part 'session.g.dart';
part 'session.mapper.dart';

/// Database session configuration.
@freezed
@MappableClass()
interface class DatabaseSessionConfiguration
    with DatabaseSessionConfigurationMappable, _$DatabaseSessionConfiguration {
  static const ReplicationMode defaultReplicationMode = ReplicationMode.none;

  const DatabaseSessionConfiguration._();

  const factory DatabaseSessionConfiguration({
    /// Database connection timeout.
    Duration? connectTimeout,

    /// The timezone of this connection for date operations that don't specify a timezone.
    String? timeZone,

    /// The replication mode for connecting in streaming replication mode.
    @Default(DatabaseSessionConfiguration.defaultReplicationMode)
    ReplicationMode replicationMode,
  }) = _DatabaseSessionConfiguration;

  /// Postgres session settings based on this configuration.
  PgSessionSettings toPgSessionSettings() => PgSessionSettings(
        connectTimeout: connectTimeout,
        timeZone: timeZone,
        replicationMode: replicationMode,
      );

  factory DatabaseSessionConfiguration.fromJson(Map<String, dynamic> json) =>
      _$DatabaseSessionConfigurationFromJson(json);
}
