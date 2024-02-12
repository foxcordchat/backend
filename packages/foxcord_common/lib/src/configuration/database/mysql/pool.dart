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
  const MySQLDatabasePoolConfiguration._();

  const factory MySQLDatabasePoolConfiguration({
    /// Database host.
    @Default('localhost') //
    String host,

    /// Database port.
    @Default(3306) //
    int port,

    /// Database name.
    @Default('foxcord') //
    String database,

    /// Database username.
    @Default('root') //
    String username,

    /// Database password.
    @Default('') //
    String password,

    /// Maximum connections.
    @Default(5) //
    int maxConnections,

    /// Database collation.
    @Default('utf8_general_ci') //
    String collation,

    /// Connection timeout.
    @Default(Duration(seconds: 10)) //
    Duration timeout,

    /// Use SSL?
    @Default(false) //
    bool secure,
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
