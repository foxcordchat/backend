import 'package:cryptography/cryptography.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:protobuf/protobuf.dart';

import '../../../gen/proto/common/serial/v1/typed_message.pb.dart';
import '../../../gen/proto/foxcord/service/password/v1/argon2.pb.dart';

part 'password.freezed.dart';
part 'password.g.dart';
part 'password.mapper.dart';

/// Password hashing configuration.
@Freezed(unionKey: 'algorithm')
@MappableClass()
interface class PasswordConfiguration
    with PasswordConfigurationMappable, _$PasswordConfiguration {
  const PasswordConfiguration._();

  /// Default maximum number of parallel computations.
  static const int _argon2DefaultParallelism = 1;

  /// Default number of 1kB blocks of memory needed to compute the hash.
  static const int _argon2DefaultMemory = 19000;

  /// Default number of iterations.
  static const int _argon2DefaultIterations = 2;

  /// Default hash length.
  static const int _argon2DefaultHashLength = 32;

  /// Argon2 configuration.
  const factory PasswordConfiguration.argon2id({
    /// Maximum number of parallel computations.
    @Default(PasswordConfiguration._argon2DefaultParallelism) int parallelism,

    /// Number of iterations.
    @Default(PasswordConfiguration._argon2DefaultIterations) int iterations,

    /// Number of 1kB blocks of memory needed to compute the hash.
    @Default(PasswordConfiguration._argon2DefaultMemory) int memory,

    /// Hash length.
    @Default(PasswordConfiguration._argon2DefaultHashLength) int hashLength,
  }) = _PasswordConfigurationArgon2id;

  /// Get Key Derivation algorithm based on this configuration.
  KdfAlgorithm get kdfAlgorithm => switch (this) {
        _PasswordConfigurationArgon2id(
          :final parallelism,
          :final memory,
          :final iterations,
          :final hashLength,
        ) =>
          Argon2id(
            parallelism: parallelism,
            memory: memory,
            iterations: iterations,
            hashLength: hashLength,
          ),
        _ => throw UnimplementedError(),
      };

  /// Get KDF configuration message.
  GeneratedMessage get _kdfConfigurationMessage => switch (this) {
        _PasswordConfigurationArgon2id(
          :final parallelism,
          :final memory,
          :final iterations,
          :final hashLength,
        ) =>
          Argon2Options(
            type: Argon2Options_Argon2Type.ARGON2_TYPE_ARGON2ID,
            version: 19,
            parallelism: parallelism,
            memory: memory,
            iterations: iterations,
            hashLength: hashLength,
          ),
        _ => throw UnimplementedError(),
      };

  /// Get message type for this KDF.
  String get _messageType => switch (this) {
        _PasswordConfigurationArgon2id() => "Argon2",
        _ => throw UnimplementedError(),
      };

  /// Get password hashing configuration.
  TypedMessage get configurationMessage => TypedMessage(
        type: _messageType,
        message: _kdfConfigurationMessage.writeToBuffer(),
      );

  factory PasswordConfiguration.fromConfigurationMessage(TypedMessage message) {
    switch (message.type) {
      case "Argon2":
        final options = Argon2Options.fromBuffer(message.message);
        return PasswordConfiguration.argon2id(
          parallelism: options.parallelism,
          memory: options.memory,
          iterations: options.iterations,
          hashLength: options.hashLength,
        );
      default:
        throw UnimplementedError();
    }
  }

  factory PasswordConfiguration.fromJson(Map<String, dynamic> json) =>
      _$PasswordConfigurationFromJson(json);
}
