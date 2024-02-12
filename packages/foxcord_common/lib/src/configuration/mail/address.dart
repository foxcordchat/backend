import 'package:dart_mappable/dart_mappable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mailer/mailer.dart';

part 'address.freezed.dart';

part 'address.g.dart';

part 'address.mapper.dart';

/// Mailer address configuration.
@freezed
@MappableClass()
interface class MailerAddressConfiguration
    with MailerAddressConfigurationMappable, _$MailerAddressConfiguration {
  const MailerAddressConfiguration._();

  const factory MailerAddressConfiguration(
    /// Mail.
    String mail, {
    /// Name.
    String? name,
  }) = _MailerAddressConfiguration;

  /// Get address from this configuration.
  Address get address => Address(mail, name);

  factory MailerAddressConfiguration.fromJson(Map<String, dynamic> json) =>
      _$MailerAddressConfigurationFromJson(json);
}
