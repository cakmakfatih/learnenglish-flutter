import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../../domain/entities/language.dart';
import '../models/language_model.dart';

abstract class QuizLocalDataSource {
  Future<LanguageModel> getLanguage();
  Future<bool> setLanguage(LanguageModel language);
  Future<List<Language>> getLanguages();
}

const SELECTED_LANGUAGE = 'SELECTED_LANGUAGE';

class QuizLocalDataSourceImpl implements QuizLocalDataSource {
  final SharedPreferences sharedPreferences;

  QuizLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<LanguageModel> getLanguage() async {
    final selectedLanguage = sharedPreferences.getString(SELECTED_LANGUAGE);

    if (selectedLanguage == null) {
      throw CacheException();
    }

    final jsonMap = json.decode(selectedLanguage);

    return LanguageModel.fromJson(jsonMap);
  }

  @override
  Future<bool> setLanguage(LanguageModel language) async {
    return sharedPreferences.setString(
        SELECTED_LANGUAGE, json.encode(language.toJson()));
  }

  @override
  Future<List<LanguageModel>> getLanguages() async {
    return languages;
  }
}
