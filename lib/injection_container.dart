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
import 'features/quiz/presentation/bloc/quiz_bloc.dart';

GetIt sl = GetIt.I;

void init() async {
  //! Quiz Feature

  sl.registerLazySingleton<QuizBloc>(
    () => QuizBloc(
      getLanguage: sl(),
      getLanguages: sl(),
      setLanguage: sl(),
      getQuestion: sl(),
    ),
  );

  // usecases
  sl.registerLazySingleton(() => GetLanguage(sl()));
  sl.registerLazySingleton(() => GetLanguages(sl()));
  sl.registerLazySingleton(() => SetLanguage(sl()));
  sl.registerLazySingleton(() => GetQuestion(sl()));

  // repositories
  sl.registerLazySingleton<QuizRepository>(
    () => QuizRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );

  // data sources
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
