import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:learnenglish/features/quiz/domain/entities/question.dart';
import 'package:learnenglish/features/quiz/domain/usecases/text_to_speech.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/map_failure_to_message.dart';
import '../../domain/entities/language.dart';
import '../../domain/usecases/get_language.dart';
import '../../domain/usecases/get_languages.dart';
import '../../domain/usecases/get_question.dart';
import '../../domain/usecases/set_language.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  final GetLanguage getLanguage;
  final GetLanguages getLanguages;
  final GetQuestion getQuestion;
  final SetLanguage setLanguage;
  final GetTextToSpeechAudio getTextToSpeechAudio;

  QuizBloc({
    @required GetLanguage getLanguage,
    @required GetLanguages getLanguages,
    @required GetQuestion getQuestion,
    @required SetLanguage setLanguage,
    @required GetTextToSpeechAudio getTextToSpeechAudio,
  })  : assert(getLanguage != null),
        assert(getLanguages != null),
        assert(getQuestion != null),
        assert(setLanguage != null),
        assert(getTextToSpeechAudio != null),
        getLanguage = getLanguage,
        getLanguages = getLanguages,
        getQuestion = getQuestion,
        setLanguage = setLanguage,
        getTextToSpeechAudio = getTextToSpeechAudio,
        super(QuizInitial());

  @override
  Stream<QuizState> mapEventToState(
    QuizEvent event,
  ) async* {
    if (event is SetStartPageEvent) {
      final languages = await getLanguages(NoParams());

      yield* languages.fold((failure) async* {
        yield QuizError(
          failure: failure,
          message: mapFailureToMessage(failure),
        );
      }, (languages) async* {
        final selectedLanguage = await getLanguage(NoParams());

        yield* selectedLanguage.fold((failure) async* {
          yield QuizSelectLanguage(languages: languages);
        }, (language) async* {
          yield QuizMain(
            language: language,
            languages: languages,
          );
        });
      });
    } else if (event is SetLanguageEvent) {
      final result =
          await setLanguage(SetLanguageParams(language: event.language));

      yield* result.fold((failure) async* {
        yield QuizError(
          failure: failure,
          message: mapFailureToMessage(failure),
        );
      }, (_) async* {
        yield QuizMain(
          language: event.language,
          languages: (state as QuizSelectLanguage).languages,
        );
      });
    } else if (event is GetQuestionEvent) {
      yield (state as QuizMain).copyWith(
        isLoading: true,
        selectedAnswerIndex: -1,
        question: null,
        audioUrl: "-1",
      );

      final questionOrFailure = await getQuestion(
        GetQuestionParams(language: (state as QuizMain).language),
      );

      yield* questionOrFailure.fold((failure) async* {
        yield QuizError(
          failure: failure,
          message: mapFailureToMessage(failure),
        );
      }, (question) async* {
        yield (state as QuizMain).copyWith(
          question: question,
          isLoading: false,
        );
      });
    } else if (event is SelectAnswerEvent) {
      yield (state as QuizMain)
          .copyWith(selectedAnswerIndex: event.answerIndex, isLoading: false);
    } else if (event is SetLanguageFromDropdownEvent) {
      yield (state as QuizMain)
          .copyWith(isLoading: true, selectedAnswerIndex: null, question: null);

      final result =
          await setLanguage(SetLanguageParams(language: event.language));

      yield* result.fold((failure) async* {
        yield QuizError(
          failure: failure,
          message: mapFailureToMessage(failure),
        );
      }, (_) async* {
        yield (state as QuizMain).copyWith(
          audioUrl: "-1",
          language: event.language,
          isLoading: false,
        );

        add(GetQuestionEvent());
      });
    } else if (event is PlayTextEvent) {
      yield (state as QuizMain).copyWith(
        isAudioLoading: true,
        isLoading: false,
      );

      if ((state as QuizMain).audioUrl != "-1") {
        _audioPlayer.play((state as QuizMain).audioUrl);

        yield (state as QuizMain).copyWith(
          isAudioLoading: false,
          isLoading: false,
        );
      } else {
        final urlOrFailure = await getTextToSpeechAudio(
          GetTextToSpeechAudioParams(
            text: (state as QuizMain)
                .question
                .words[(state as QuizMain).question.answer],
          ),
        );

        yield* urlOrFailure.fold((failure) async* {
          yield (state as QuizMain).copyWith(
            isAudioLoading: false,
            isLoading: false,
          );
        }, (audioUrl) async* {
          _audioPlayer.play(audioUrl);

          yield (state as QuizMain).copyWith(
            isAudioLoading: false,
            isLoading: false,
            audioUrl: audioUrl,
          );
        });
      }
    }
  }
}
