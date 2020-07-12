import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'features/quiz/data/datasources/quiz_local_data_source.dart';
import 'features/quiz/data/datasources/quiz_remote_data_source.dart';
import 'features/quiz/data/repositories/quiz_repository_impl.dart';
import 'features/quiz/domain/repositories/quiz_repository.dart';
import 'features/quiz/domain/usecases/get_language.dart';
import 'features/quiz/domain/usecases/get_languages.dart';
import 'features/quiz/domain/usecases/get_question.dart';
import 'features/quiz/domain/usecases/set_language.dart';
import 'features/quiz/domain/usecases/text_to_speech.dart';
import 'features/quiz/presentation/bloc/quiz_bloc.dart';
import 'features/settings/data/datasources/settings_local_data_source.dart';
import 'features/settings/data/repositories/settings_repository_impl.dart';
import 'features/settings/domain/repositories/settings_repository.dart';
import 'features/settings/domain/usecases/get_theme.dart';
import 'features/settings/domain/usecases/set_theme.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';

GetIt sl = GetIt.I;

void init() async {
  //! Settings Feature

  // bloc
  sl.registerLazySingleton<SettingsBloc>(() => SettingsBloc(
        getTheme: sl(),
        setTheme: sl(),
      ));

  // usecases
  sl.registerLazySingleton(() => SetTheme(sl()));
  sl.registerLazySingleton(() => GetTheme(sl()));

  // repositories
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  // datasources
  sl.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Quiz Feature

  // bloc
  sl.registerLazySingleton<QuizBloc>(
    () => QuizBloc(
      getLanguage: sl(),
      getLanguages: sl(),
      setLanguage: sl(),
      getQuestion: sl(),
      getTextToSpeechAudio: sl(),
    ),
  );

  // usecases
  sl.registerLazySingleton(() => GetLanguage(sl()));
  sl.registerLazySingleton(() => GetLanguages(sl()));
  sl.registerLazySingleton(() => SetLanguage(sl()));
  sl.registerLazySingleton(() => GetQuestion(sl()));
  sl.registerLazySingleton(() => GetTextToSpeechAudio(sl()));

  // repositories
  sl.registerLazySingleton<QuizRepository>(
    () => QuizRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );

  // datasources
  sl.registerLazySingleton<QuizRemoteDataSource>(
    () => QuizRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<QuizLocalDataSource>(
    () => QuizLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! External

  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<http.Client>(() => http.Client());
}
