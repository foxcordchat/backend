import 'package:foxcord_common/generated/structure/prisma/client.dart';
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
      userInfo: userInfo,
      host: host,
      port: port,
      path: database,
      queryParameters: options);

  /// Returns a authentication user info based on this configuration.
  String? get userInfo => password != null ? "$username:$password" : username;

  /// Returns a datasource based on this configuration.
  Datasources toDatasource() => Datasources(
        db: toConnectionUri().toString(),
      );

  factory DatabaseConfiguration.fromJson(Map<String, dynamic> json) =>
      _$DatabaseConfigurationFromJson(json);
}
