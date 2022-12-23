part of 'settings_bloc.dart';

@immutable
class SettingsState extends Equatable {
  final UserModel user;
  final AuthenticationStatus authStatus;

  final Locals _locale;
  final MoreBrightness brightness;

  const SettingsState({
    this.user = UserModel.empty,
    this.authStatus = AuthenticationStatus.unauthenticated,
    Locals locale = Locals.systemDefault,
    this.brightness = MoreBrightness.systemDefault,
  }) : _locale = locale;

  Locale get locale {
    if (_locale != Locals.systemDefault) return Locale(_locale.name);

    if (kIsWeb) {
      var lang = Uri.base.queryParameters['lang'];
      if (lang != null &&
          AppLocalizations.supportedLocales
              .any((_) => _.languageCode == lang)) {
        try {
          return Locale(Locals.values.byName(lang).name); // double check
        } catch (_) {}
      }
    }

    return Locale(_locale.name);
  }

  SettingsState copyWith({
    UserModel? user,
    AuthenticationStatus? authStatus,
    Locals? locale,
    MoreBrightness? brightness,
  }) =>
      SettingsState(
        user: user ?? this.user,
        authStatus: authStatus ?? this.authStatus,
        locale: locale ?? _locale,
        brightness: brightness ?? this.brightness,
      );

  @override
  List<Object?> get props => [
        _locale,
        brightness,
        user,
        authStatus,
      ];

  static SettingsState fromJson(Map<String, dynamic> json) => SettingsState(
        user: UserModel.fromJson(json['user']),
        locale: Locals.values.byName(json['locale']),
        authStatus: AuthenticationStatus.values.byName(json['authStatus']),
        brightness: MoreBrightness.values.byName(json['brightness']),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'user': user.toJson(),
        'locale': _locale.name,
        'authStatus': authStatus.name,
        'brightness': brightness.name,
      };
}
