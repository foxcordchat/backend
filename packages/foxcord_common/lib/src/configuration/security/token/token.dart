import 'package:dart_mappable/dart_mappable.dart';
import 'package:foxcord_common/src/configuration/security/token/codec.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'token.freezed.dart';
part 'token.g.dart';
part 'token.mapper.dart';

/// Token configuration.
@freezed
@MappableClass()
interface class TokenConfiguration
    with TokenConfigurationMappable, _$TokenConfiguration {
  const TokenConfiguration._();

  /// Default token codec configuration.
  static const TokenCodecConfiguration _tokenCodecConfigurationDefault =
      TokenCodecConfiguration.base64();

  const factory TokenConfiguration({
    /// Codec to use with tokens.
    @Default(TokenConfiguration._tokenCodecConfigurationDefault)
    TokenCodecConfiguration codec,
  }) = _TokenConfiguration;

  factory TokenConfiguration.fromJson(Map<String, dynamic> json) =>
      _$TokenConfigurationFromJson(json);
}
