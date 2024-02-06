import 'package:injectable/injectable.dart';

import 'injectable.module.dart' as injectable_module;

/// Initialize FoxCord Common micro-package.
@InjectableInit.microPackage()
final class FoxcordCommonPackageModule
    extends injectable_module.FoxcordCommonPackageModule {}
