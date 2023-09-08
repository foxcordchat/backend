import 'package:freezed_annotation/freezed_annotation.dart';

part 'database.freezed.dart';

part 'database.g.dart';

/// Database connection options.
@freezed
interface class DatabaseConfiguration with _$DatabaseConfiguration {
  const DatabaseConfiguration._();

  const factory DatabaseConfiguration({
    /// RDBMS type.
    required String type,

    /// Database name.
    required String database,

    /// Database host.
    String? host,

    /// Database host port.
    int? port,

    /// Database username.
    String? username,

    /// Database password.
    String? password,

    /// Advanced database connection uri options.
    Map<String, String>? options,
  }) = _DatabaseConfiguration;

  /// Returns a database connection uri based on this configuration.
  Uri toConnectionUri() => Uri(
        scheme: type,
        userInfo: password != null ? "$username:$password" : username,
        host: host,
        port: port,
        path: database,
        queryParameters: options,
      );

  factory DatabaseConfiguration.fromJson(Map<String, dynamic> json) =>
      _$DatabaseConfigurationFromJson(json);
}
