import 'package:foxcord_common/src/configuration/database.dart';
import 'package:test/test.dart';

Future<void> main() async {
  const Map<String, dynamic> basePostgresConnectionOptions = {
    "type": "postgres",
    "host": "192.168.0.1",
    "port": 5432,
    "database": "database",
  };

  group(DatabaseConfiguration, () {
    test('should create postgres connection uri without credentials.', () {
      final DatabaseConfiguration configuration =
          DatabaseConfiguration.fromJson(basePostgresConnectionOptions);

      expect(
        configuration.toConnectionUri(),
        Uri.parse("postgres://192.168.0.1:5432/database"),
      );
    });

    test('should create postgres connection uri without password.', () {
      const Map<String, dynamic> connectionOptions = {
        "username": "username",
        ...basePostgresConnectionOptions,
      };

      final DatabaseConfiguration configuration =
          DatabaseConfiguration.fromJson(connectionOptions);

      expect(
        configuration.toConnectionUri(),
        Uri.parse("postgres://username@192.168.0.1:5432/database"),
      );
    });

    test('should create postgres connection uri with password.', () {
      const Map<String, dynamic> connectionOptions = {
        "username": "username",
        "password": "password",
        ...basePostgresConnectionOptions,
      };

      final DatabaseConfiguration configuration =
          DatabaseConfiguration.fromJson(connectionOptions);

      expect(
        configuration.toConnectionUri(),
        Uri.parse("postgres://username:password@192.168.0.1:5432/database"),
      );
    });

    test('should create postgres connection uri with options.', () {
      const Map<String, dynamic> connectionOptions = {
        "options": {
          "sslmode": "disable",
          "connect_timeout": "10",
        },
        ...basePostgresConnectionOptions,
      };

      final DatabaseConfiguration configuration =
          DatabaseConfiguration.fromJson(connectionOptions);

      expect(
        configuration.toConnectionUri(),
        Uri.parse(
            "postgres://192.168.0.1:5432/database?sslmode=disable&connect_timeout=10"),
      );
    });
  });
}
