import 'package:dart_mappable/dart_mappable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'address.dart';
import 'provider.dart';

part 'mailer.freezed.dart';
part 'mailer.g.dart';
part 'mailer.mapper.dart';

/// Mailer configuration.
@freezed
@MappableClass()
interface class MailerConfiguration
    with MailerConfigurationMappable, _$MailerConfiguration {
  const MailerConfiguration._();

  const factory MailerConfiguration({
    /// Provider configuration.
    required MailerProviderConfiguration provider,

    /// Email author configuration.
    required MailerAddressConfiguration from,
  }) = _MailerConfiguration;

  factory MailerConfiguration.fromJson(Map<String, dynamic> json) =>
      _$MailerConfigurationFromJson(json);
}
