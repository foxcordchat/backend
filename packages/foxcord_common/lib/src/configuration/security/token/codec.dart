import 'dart:convert';

import 'package:base85/base85.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'codec.freezed.dart';

part 'codec.g.dart';

part 'codec.mapper.dart';

/// Token codec configuration.
@Freezed(fallbackUnion: 'base64')
@MappableClass()
interface class TokenCodecConfiguration
    with TokenCodecConfigurationMappable, _$TokenCodecConfiguration {
  const TokenCodecConfiguration._();

  /// Base64 encoding.
  const factory TokenCodecConfiguration.base64({
    /// Use URL-safe base64 version.
    @Default(true) //
    bool urlSafe,
  }) = _TokenCodecConfigurationBase64;

  /// Base85 encoding.
  const factory TokenCodecConfiguration.base85({
    /// Alphabet to use.
    @Default(
        '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!#\$%&()*+-;<=>?@^_`{|}~') //
    String alphabet,

    /// Algorithm to use.
    @Default(AlgoType.ascii85) AlgoType algorithm,
  }) = _TokenCodecConfigurationBase85;

  /// Codec based on this configuration.
  Codec<List<int>, String> get codec => switch (this) {
        _TokenCodecConfigurationBase64(:final urlSafe) =>
          urlSafe ? base64Url : base64,
        _TokenCodecConfigurationBase85(:final alphabet, :final algorithm) =>
          Base85Codec(alphabet, algorithm),
        _ => throw UnimplementedError(),
      } as Codec<List<int>, String>;

  factory TokenCodecConfiguration.fromJson(Map<String, dynamic> json) =>
      _$TokenCodecConfigurationFromJson(json);
}
