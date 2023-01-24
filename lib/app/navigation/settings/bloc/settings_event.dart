part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class AppLocalChanged extends SettingsEvent {
  final Locals locale;

  const AppLocalChanged(this.locale);

  @override
  List<Object?> get props => [locale];
}

class AppBrightnessChanged extends SettingsEvent {
  final MoreBrightness brightness;

  const AppBrightnessChanged(this.brightness);

  @override
  List<Object?> get props => [brightness];
}

class AppLogoutRequested extends SettingsEvent {
  const AppLogoutRequested();
}

class _AppUserChanged extends SettingsEvent {
  const _AppUserChanged(this.user);

  final UserModel user;

  @override
  List<Object?> get props => [user];
}
