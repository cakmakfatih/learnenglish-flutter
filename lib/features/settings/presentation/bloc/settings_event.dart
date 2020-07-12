part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List get props => [];
}

class SettingsSwitchThemeEvent extends SettingsEvent {}

class SettingsSetInitialThemeEvent extends SettingsEvent {}
