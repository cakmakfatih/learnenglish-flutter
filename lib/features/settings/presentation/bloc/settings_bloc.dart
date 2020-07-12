import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/styles/le_theme.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_theme.dart';
import '../../domain/usecases/set_theme.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetTheme getTheme;
  final SetTheme setTheme;

  SettingsBloc({
    @required GetTheme getTheme,
    @required SetTheme setTheme,
  })  : assert(getTheme != null),
        assert(setTheme != null),
        getTheme = getTheme,
        setTheme = setTheme,
        super(SettingsState.initial());

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is SettingsSetInitialThemeEvent) {
      final themeIsDark = await getTheme(NoParams());

      yield* themeIsDark.fold((failure) async* {
        setTheme(SetThemeParams(isDark: false));

        yield state.copyWith(theme: LeTheme.light(), isDark: false);
      }, (isDark) async* {
        if (isDark) {
          yield state.copyWith(theme: LeTheme.dark(), isDark: true);
        } else {
          yield state.copyWith(theme: LeTheme.light(), isDark: false);
        }
      });
    } else if (event is SettingsSwitchThemeEvent) {
      if (state.isDark) {
        setTheme(SetThemeParams(isDark: false));

        yield state.copyWith(theme: LeTheme.light(), isDark: false);
      } else {
        setTheme(SetThemeParams(isDark: true));

        yield state.copyWith(theme: LeTheme.dark(), isDark: true);
      }
    }
  }
}
