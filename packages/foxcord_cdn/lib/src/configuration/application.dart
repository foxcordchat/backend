import 'package:dart_mappable/dart_mappable.dart';
import 'package:foxcord_common/foxcord_common.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'application.config.dart';

part 'application.freezed.dart';
part 'application.g.dart';
part 'application.mapper.dart';

/// FoxCord CDN Server configuration.
@freezed
@MappableClass()
@InjectableInit(externalPackageModulesBefore: [
  ExternalModule(FoxcordCommonPackageModule),
])
interface class ApplicationConfiguration
    with ApplicationConfigurationMappable, _$ApplicationConfiguration {
  const ApplicationConfiguration._();

  const factory ApplicationConfiguration({
    /// Database connection configuration.
    @Default(DatabaseConfiguration.memory()) DatabaseConfiguration database,

    /// Storage configuration.
    @Default(StorageConfiguration.memory()) StorageConfiguration storage,
  }) = _ApplicationConfiguration;

  /// Configure DI container.
  void configureDependencies() => GetIt.instance
    ..registerSingleton(database)
    ..registerSingleton(storage)
    ..init();

  factory ApplicationConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ApplicationConfigurationFromJson(json);
}
