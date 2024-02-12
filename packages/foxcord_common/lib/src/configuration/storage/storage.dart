import 'dart:io';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:file/chroot.dart';
import 'package:file/file.dart' hide Directory;
import 'package:file/local.dart';
import 'package:file/memory.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../converter/dart/io/directory.dart';

part 'storage.freezed.dart';

part 'storage.g.dart';

part 'storage.mapper.dart';

/// Storage configuration.
@Freezed(fallbackUnion: 'memory')
@MappableClass()
interface class StorageConfiguration
    with StorageConfigurationMappable, _$StorageConfiguration {
  const StorageConfiguration._();

  /// In-memory storage.
  const factory StorageConfiguration.memory() = _StorageConfigurationMemory;

  /// Local storage.
  const factory StorageConfiguration.local() = _StorageConfigurationLocal;

  /// Chroot storage.
  const factory StorageConfiguration.chroot({
    /// Path in delegate filesystem.
    @DartIODirectoryConverter() //
    required Directory path,

    /// Delegate filesystem.
    required StorageConfiguration delegate,
  }) = _StorageConfigurationChroot;

  /// S3 storage.
  const factory StorageConfiguration.s3() = _StorageConfigurationS3;

  /// Google Cloud storage.
  const factory StorageConfiguration.gcloud() = _StorageConfigurationGcloud;

  /// Get filesystem based on storage config.
  FileSystem get fileSystem => switch (this) {
        _StorageConfigurationMemory() => MemoryFileSystem(),
        _StorageConfigurationLocal() => LocalFileSystem(),
        _StorageConfigurationChroot(:final path, :final delegate) =>
          ChrootFileSystem(
            delegate.fileSystem,
            delegate.fileSystem.path.canonicalize(path.path),
          ),
        _ => throw UnimplementedError("Unknown storage impl"),
      };

  factory StorageConfiguration.fromJson(Map<String, dynamic> json) =>
      _$StorageConfigurationFromJson(json);
}
