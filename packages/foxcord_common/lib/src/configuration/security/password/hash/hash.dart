import 'package:cryptography/cryptography.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:foxcord_common/gen/proto/common/serial/v1/typed_message.pb.dart';
import 'package:foxcord_common/gen/proto/foxcord/service/authentication/password/v1/argon2.pb.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:protobuf/protobuf.dart';


part 'hash.freezed.dart';
part 'hash.g.dart';
part 'hash.mapper.dart';

/// PasswordHash hashing configuration.
@Freezed(unionKey: 'algorithm')
@MappableClass()
interface class PasswordHashConfiguration
    with PasswordHashConfigurationMappable, _$PasswordHashConfiguration {
  const PasswordHashConfiguration._();

  /// Argon2 TypedMessage type.
  static const String _argon2Type = "Argon2";

  /// Default maximum number of parallel computations.
  static const int _argon2DefaultParallelism = 1;

  /// Default number of 1kB blocks of memory needed to compute the hash.
  static const int _argon2DefaultMemory = 19000;

  /// Default number of iterations.
  static const int _argon2DefaultIterations = 2;

  /// Default hash length.
  static const int _argon2DefaultHashLength = 32;

  /// Argon2 configuration.
  const factory PasswordHashConfiguration.argon2id({
    /// Maximum number of parallel computations.
    @Default(PasswordHashConfiguration._argon2DefaultParallelism) int parallelism,

    /// Number of iterations.
    @Default(PasswordHashConfiguration._argon2DefaultIterations) int iterations,

    /// Number of 1kB blocks of memory needed to compute the hash.
    @Default(PasswordHashConfiguration._argon2DefaultMemory) int memory,

    /// Hash length.
    @Default(PasswordHashConfiguration._argon2DefaultHashLength) int hashLength,
  }) = _PasswordHashConfigurationArgon2id;

  /// Get Key Derivation algorithm based on this configuration.
  KdfAlgorithm get kdfAlgorithm => switch (this) {
    _PasswordHashConfigurationArgon2id(
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
    _PasswordHashConfigurationArgon2id(
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
    _PasswordHashConfigurationArgon2id() => _argon2Type,
    _ => throw UnimplementedError(),
  };

  /// Get PasswordHash hashing configuration.
  TypedMessage get configurationMessage => TypedMessage(
    type: _messageType,
    message: _kdfConfigurationMessage.writeToBuffer(),
  );

  factory PasswordHashConfiguration.fromConfigurationMessage(TypedMessage message) {
    switch (message.type) {
      case _argon2Type:
        final options = Argon2Options.fromBuffer(message.message);
        return PasswordHashConfiguration.argon2id(
          parallelism: options.parallelism,
          memory: options.memory,
          iterations: options.iterations,
          hashLength: options.hashLength,
        );
      default:
        throw UnimplementedError();
    }
  }

  factory PasswordHashConfiguration.fromJson(Map<String, dynamic> json) =>
      _$PasswordHashConfigurationFromJson(json);
}
