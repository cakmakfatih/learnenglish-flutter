import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';

abstract class SettingsLocalDataSource {
  Future<bool> getTheme();
  Future<bool> setTheme(bool isDark);
}

const THEME_IS_DARK = "THEME_IS_DARK";

class SettingsLocalDataSourceImpl extends SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;

  SettingsLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<bool> getTheme() async {
    final themeIsDark = sharedPreferences.getBool(THEME_IS_DARK);

    if (themeIsDark == null) {
      throw CacheException();
    }

    return themeIsDark;
  }

  @override
  Future<bool> setTheme(bool isDark) async {
    return sharedPreferences.setBool(THEME_IS_DARK, isDark);
  }
}
