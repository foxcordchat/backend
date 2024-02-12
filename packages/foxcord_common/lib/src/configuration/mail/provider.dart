import 'package:dart_mappable/dart_mappable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mailer/smtp_server.dart';

part 'provider.freezed.dart';

part 'provider.g.dart';

part 'provider.mapper.dart';

/// Mailer provider configuration.
@Freezed(fallbackUnion: 'none')
@MappableClass()
interface class MailerProviderConfiguration
    with MailerProviderConfigurationMappable, _$MailerProviderConfiguration {
  const MailerProviderConfiguration._();

  /// Disables mailer.
  const factory MailerProviderConfiguration.none() =
      _MailerProviderConfigurationNone;

  /// Smtp mailer.
  const factory MailerProviderConfiguration.smtp({
    /// Host to use.
    @Default('localhost') //
    String host,

    /// Port to use.
    @Default(587) //
    int port,

    /// Ignore bad server SSL certificate.
    @Default(false) //
    bool ignoreBadCertificate,

    /// Use SSL for communication with server.
    @Default(false) //
    bool ssl,

    /// Allow insecure communication with server.
    @Default(false) //
    bool allowInsecure,

    /// Username of mailing user.
    String? username,

    /// Password of mailing user.
    String? password,

    /// XOAuth2 of mailing user.
    String? xoauth2Token,
  }) = _MailerProviderConfigurationSmtp;

  /// Gmail mailer provider.
  const factory MailerProviderConfiguration.gmail(
    /// Username of mailing user.
    String username,

    /// Password of mailing user.
    String password,
  ) = _MailerProviderConfigurationGmail;

  /// Outlook Hotmail mailer provider.
  const factory MailerProviderConfiguration.hotmail(
    /// Username of mailing user.
    String username,

    /// Password of mailing user.
    String password,
  ) = _MailerProviderConfigurationHotmail;

  /// Mailgun mailer provider.
  const factory MailerProviderConfiguration.mailgun(
    /// Username of mailing user.
    String username,

    /// Password of mailing user.
    String password,
  ) = _MailerProviderConfigurationMailgun;

  /// Papercut mailer provider.
  const factory MailerProviderConfiguration.papercut({
    /// Host to use.
    @Default('localhost') //
    String host,

    /// Port to use.
    @Default(25) //
    int port,
  }) = _MailerProviderConfigurationPapercut;

  /// Tencent QQ mailer provider.
  const factory MailerProviderConfiguration.qq(
    /// Username of mailing user.
    String username,

    /// Password of mailing user.
    String password,
  ) = _MailerProviderConfigurationQQ;

  /// Yahoo mailer provider.
  const factory MailerProviderConfiguration.yahoo(
    /// Username of mailing user.
    String username,

    /// Password of mailing user.
    String password,
  ) = _MailerProviderConfigurationYahoo;

  /// Yandex mailer provider
  const factory MailerProviderConfiguration.yandex(
    /// Username of mailing user.
    String username,

    /// Password of mailing user.
    String password,
  ) = _MailerProviderConfigurationYandex;

  /// Zoho mailer provider.
  const factory MailerProviderConfiguration.zoho(
    /// Username of mailing user.
    String username,

    /// Password of mailing user.
    String password,
  ) = _MailerProviderConfigurationZoho;

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
