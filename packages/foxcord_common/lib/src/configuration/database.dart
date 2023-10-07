import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stormberry/stormberry.dart';

part 'database.freezed.dart';

part 'database.g.dart';

/// Database connection options.
@freezed
interface class DatabaseConfiguration with _$DatabaseConfiguration {
  const DatabaseConfiguration._();

  const factory DatabaseConfiguration({
    /// Database name.
    String? database,

    /// Database host.
    String? host,

    /// Database host port.
    int? port,

    /// Database username.
    String? username,

    /// Database password.
    String? password,

    /// Advanced database connection options.
    Map<String, String>? options,
  }) = _DatabaseConfiguration;

  /// Returns a datasource based on this configuration.
  Database construct() => Database(
      host: host,
      port: port,
      database: database,
      user: username,
      password: password,
      useSSL: options?['sslmode'] == 'enable',
      debugPrint: options?['debug'] == 'enable');

  factory DatabaseConfiguration.fromJson(Map<String, dynamic> json) => _$DatabaseConfigurationFromJson(json);
}
