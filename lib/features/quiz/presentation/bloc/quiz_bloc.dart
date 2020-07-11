import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:learnenglish/core/error/failures.dart';
import 'package:learnenglish/core/usecases/usecase.dart';
import 'package:learnenglish/core/utils/map_failure_to_message.dart';
import 'package:learnenglish/features/quiz/domain/entities/language.dart';

import '../../domain/usecases/get_language.dart';
import '../../domain/usecases/get_languages.dart';
import '../../domain/usecases/get_question.dart';
import '../../domain/usecases/set_language.dart';
import 'package:meta/meta.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final GetLanguage getLanguage;
  final GetLanguages getLanguages;
  final GetQuestion getQuestion;
  final SetLanguage setLanguage;

  QuizBloc({
    @required GetLanguage getLanguage,
    @required GetLanguages getLanguages,
    @required GetQuestion getQuestion,
    @required SetLanguage setLanguage,
  })  : assert(getLanguage != null),
        assert(getLanguages != null),
        assert(getQuestion != null),
        assert(setLanguage != null),
        getLanguage = getLanguage,
        getLanguages = getLanguages,
        getQuestion = getQuestion,
        setLanguage = setLanguage,
        super(QuizInitial());

  @override
  Stream<QuizState> mapEventToState(
    QuizEvent event,
  ) async* {
    if (event is SetStartPageEvent) {
      final selectedLanguage = await getLanguage(NoParams());

      yield* selectedLanguage.fold((_) async* {
        final languages = await getLanguages(NoParams());

        yield* languages.fold((failure) async* {
          yield QuizError(
            failure: failure,
            message: mapFailureToMessage(failure),
          );
        }, (languages) async* {
          yield QuizSelectLanguage(languages: languages);
        });
      }, (r) async* {
        yield QuizLoading();
      });
    }
  }
}
