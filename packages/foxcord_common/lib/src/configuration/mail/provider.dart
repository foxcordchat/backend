import 'package:dart_mappable/dart_mappable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mailer/smtp_server.dart';

part 'provider.freezed.dart';
part 'provider.g.dart';
part 'provider.mapper.dart';

/// Mailer provider configuration.
@Freezed(unionKey: 'type', fallbackUnion: 'none')
@MappableClass()
interface class MailerProviderConfiguration
    with MailerProviderConfigurationMappable, _$MailerProviderConfiguration {
  const MailerProviderConfiguration._();

  /// Default port for custom SMTP servers.
  static const _defaultSmtpPort = 587;

  /// Ignore bad certificates on custom SMTP server.
  static const _defaultSmtpIgnoreBadCertificate = false;

  /// Use ssl on custom SMTP server.
  static const _defaultSmtpSsl = false;

  /// Allow insecure communication on custom SMTP server.
  static const _defaultSmtpAllowInsecure = false;

  /// Default port of papercut SMTP server.
  static const _defaultPapercutPort = 25;

  /// Default hostname of papercut SMTP server.
  static const _defaultPapercutHost = '127.0.0.1';

  /// Disables mailer.
  const factory MailerProviderConfiguration.none() =
      _MailerProviderConfigurationNone;

  /// Smtp mailer.
  const factory MailerProviderConfiguration.smtp({
    required String host,
    @Default(MailerProviderConfiguration._defaultSmtpPort) int port,
    @Default(MailerProviderConfiguration._defaultSmtpIgnoreBadCertificate)
    bool ignoreBadCertificate,
    @Default(MailerProviderConfiguration._defaultSmtpSsl) bool ssl,
    @Default(MailerProviderConfiguration._defaultSmtpAllowInsecure)
    bool allowInsecure,
    String? username,
    String? password,
    String? xoauth2Token,
  }) = _MailerProviderConfigurationSmtp;

  /// Gmail mailer provider.
  const factory MailerProviderConfiguration.gmail(
      String username, String password) = _MailerProviderConfigurationGmail;

  /// Outlook Hotmail mailer provider.
  const factory MailerProviderConfiguration.hotmail(
      String username, String password) = _MailerProviderConfigurationHotmail;

  /// Mailgun mailer provider.
  const factory MailerProviderConfiguration.mailgun(
      String username, String password) = _MailerProviderConfigurationMailgun;

  /// Papercut mailer provider.
  const factory MailerProviderConfiguration.papercut([
    @Default(MailerProviderConfiguration._defaultPapercutHost) String host,
    @Default(MailerProviderConfiguration._defaultPapercutPort) int port,
  ]) = _MailerProviderConfigurationPapercut;

  /// Tencent QQ mailer provider.
  const factory MailerProviderConfiguration.qq(
      String username, String password) = _MailerProviderConfigurationQQ;

  /// Yahoo mailer provider.
  const factory MailerProviderConfiguration.yahoo(
      String username, String password) = _MailerProviderConfigurationYahoo;

  /// Yandex mailer provider
  const factory MailerProviderConfiguration.yandex(
      String username, String password) = _MailerProviderConfigurationYandex;

  /// Zoho mailer provider.
  const factory MailerProviderConfiguration.zoho(
      String username, String password) = _MailerProviderConfigurationZoho;

  /// Get mailer server endpoint based on this config.
  SmtpServer? get smtpServer => switch (this) {
        _MailerProviderConfigurationNone() => null,
        _MailerProviderConfigurationSmtp(
          :final host,
          :final port,
          :final ignoreBadCertificate,
          :final ssl,
          :final allowInsecure,
          :final username,
          :final password,
          :final xoauth2Token,
        ) =>
          SmtpServer(
            host,
            port: port,
            ignoreBadCertificate: ignoreBadCertificate,
            ssl: ssl,
            allowInsecure: allowInsecure,
            username: username,
            password: password,
            xoauth2Token: xoauth2Token,
          ),
        _MailerProviderConfigurationGmail(:final username, :final password) =>
          gmail(username, password),
        _MailerProviderConfigurationHotmail(:final username, :final password) =>
          hotmail(username, password),
        _MailerProviderConfigurationMailgun(:final username, :final password) =>
          mailgun(username, password),
        _MailerProviderConfigurationPapercut(:final host, :final port) =>
          SmtpServer(host, port: port, allowInsecure: true),
        _MailerProviderConfigurationQQ(:final username, :final password) =>
          qq(username, password),
        _MailerProviderConfigurationYahoo(:final username, :final password) =>
          yahoo(username, password),
        _MailerProviderConfigurationYandex(:final username, :final password) =>
          yandex(username, password),
        _MailerProviderConfigurationZoho(:final username, :final password) =>
          zoho(username, password),
        _ => throw UnimplementedError("Unknown mailer impl"),
      };

  factory MailerProviderConfiguration.fromJson(Map<String, dynamic> json) =>
      _$MailerProviderConfigurationFromJson(json);
}
