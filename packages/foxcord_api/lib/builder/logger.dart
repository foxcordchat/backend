import 'package:minerva/minerva.dart';

final class LoggersBuilder extends MinervaLoggersBuilder {
  @override
  List<Logger> build() => [
        ConsoleLogger(),
      ];
}
