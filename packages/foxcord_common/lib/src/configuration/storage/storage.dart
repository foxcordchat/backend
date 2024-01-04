import 'package:dart_mappable/dart_mappable.dart';
import 'package:file/chroot.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:file/memory.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart';

part 'storage.freezed.dart';
part 'storage.g.dart';
part 'storage.mapper.dart';

/// Storage configuration.
@Freezed(unionKey: 'type', fallbackUnion: 'memory')
@MappableClass()
interface class StorageConfiguration
    with StorageConfigurationMappable, _$StorageConfiguration {
  const StorageConfiguration._();

  /// In-memory storage.
  const factory StorageConfiguration.memory() = _StorageConfigurationMemory;

  /// Local storage.
  const factory StorageConfiguration.local({
    required String path,
  }) = _StorageConfigurationLocal;

  /// Get filesystem based on storage config.
  FileSystem get fileSystem => switch (this) {
        _StorageConfigurationMemory() => MemoryFileSystem(),
        _StorageConfigurationLocal(
          :final path,
        ) =>
          ChrootFileSystem(
            const LocalFileSystem(),
            canonicalize(path),
          ),
        _ => throw UnimplementedError("Unknown storage impl"),
      };

  factory StorageConfiguration.fromJson(Map<String, dynamic> json) =>
      _$StorageConfigurationFromJson(json);
}
