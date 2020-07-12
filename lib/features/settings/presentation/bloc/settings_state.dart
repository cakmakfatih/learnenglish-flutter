part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final LeTheme theme;
  final bool isDark;

  SettingsState({this.theme, this.isDark: false});

  factory SettingsState.initial() {
    return SettingsState(theme: LeTheme.light(), isDark: false);
  }

  SettingsState copyWith({
    LeTheme theme,
    bool isDark,
  }) {
    return SettingsState(
      theme: theme ?? LeTheme.light(),
      isDark: isDark,
    );
  }

  @override
  List<Object> get props => [
        theme,
      ];
}
