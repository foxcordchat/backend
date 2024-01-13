import 'package:dart_mappable/dart_mappable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mysql_client/mysql_client.dart';

part 'pool.freezed.dart';
part 'pool.g.dart';
part 'pool.mapper.dart';

/// MySQL database pool configuration.
@freezed
@MappableClass()
interface class MySQLDatabasePoolConfiguration
    with
        MySQLDatabasePoolConfigurationMappable,
        _$MySQLDatabasePoolConfiguration {
  /// Default MySQL port.
  static const int _defaultPort = 3306;

  /// Default MariaDB collation.
  static const String _defaultCollation = 'utf8_general_ci';

  /// Default MariaDB max connections.
  static const int _defaultMaxConnections = 5;

  /// Default MariaDB connection timeout.
  static const Duration _defaultTimeout = Duration(seconds: 10);

  /// Default MariaDB use SSL.
  static const bool _defaultSecure = false;

  const MySQLDatabasePoolConfiguration._();

  const factory MySQLDatabasePoolConfiguration({
    /// Database host.
    required String host,

    /// Database port.
    @Default(MySQLDatabasePoolConfiguration._defaultPort) int port,

    /// Database name.
    required String database,

    /// Database username.
    required String username,

    /// Database password.
    required String password,

    /// Maximum connections.
    @Default(MySQLDatabasePoolConfiguration._defaultMaxConnections)
    int maxConnections,

    /// Database collation.
    @Default(MySQLDatabasePoolConfiguration._defaultCollation) String collation,

    /// Connection timeout.
    @Default(MySQLDatabasePoolConfiguration._defaultTimeout) Duration timeout,

    /// Use SSL?
    @Default(MySQLDatabasePoolConfiguration._defaultSecure) bool secure,
  }) = _MySQLDatabasePoolConfiguration;

  /// MySQL database endpoint based on this configuration.
  MySQLConnectionPool get pool => MySQLConnectionPool(
        host: host,
        port: port,
        databaseName: database,
        userName: username,
        password: password,
        maxConnections: maxConnections,
        collation: collation,
        timeoutMs: timeout.inMilliseconds,
        secure: secure,
      );

  factory MySQLDatabasePoolConfiguration.fromJson(Map<String, dynamic> json) =>
      _$MySQLDatabasePoolConfigurationFromJson(json);
}
