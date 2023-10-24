import 'dart:io';

import 'package:minerva/minerva.dart';

import 'api.dart';
import 'logger.dart';
import 'middleware.dart';

final class SettingBuilder extends MinervaSettingBuilder {
  @override
  MinervaSetting build() => MinervaSetting(
        instance: Platform.numberOfProcessors,
        apisBuilder: ApisBuilder(),
        loggersBuilder: LoggersBuilder(),
        middlewaresBuilder: MiddlewaresBuilder(),
      );
}
