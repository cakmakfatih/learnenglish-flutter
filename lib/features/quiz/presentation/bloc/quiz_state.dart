part of 'quiz_bloc.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];
}

class QuizInitial extends QuizState {
  @override
  List<Object> get props => [];
}

class QuizLoading extends QuizState {}

class QuizError extends QuizState {
  final String message;
  final Failure failure;

  const QuizError({@required this.message, @required this.failure});

  @override
  List<Object> get props => [message, failure];
}

class QuizSelectLanguage extends QuizState {
  final List<Language> languages;

  const QuizSelectLanguage({@required this.languages});

  @override
  List<Object> get props => [languages];
}

class QuizMain extends QuizState {
  final Language language;
  final List<Language> languages;
  final Question question;
  final bool isLoading;
  final int selectedAnswerIndex;
  final String audioUrl;
  final bool isAudioLoading;

  QuizMain({
    @required this.language,
    @required this.languages,
    this.question,
    this.isLoading: false,
    this.isAudioLoading: false,
    this.selectedAnswerIndex,
    this.audioUrl,
  });

  QuizMain copyWith({
    Language language,
    List<Language> languages,
    Question question,
    bool isLoading,
    bool isAudioLoading,
    int selectedAnswerIndex,
    String audioUrl,
  }) {
    return QuizMain(
      language: language ?? this.language,
      languages: languages ?? this.languages,
      question: question ?? this.question,
      isLoading: isLoading,
      isAudioLoading: isAudioLoading,
      selectedAnswerIndex: selectedAnswerIndex ?? this.selectedAnswerIndex,
      audioUrl: audioUrl,
    );
  }

  @override
  List<Object> get props => [
        language,
        languages,
        question,
        isLoading,
        isAudioLoading,
        selectedAnswerIndex,
        audioUrl,
      ];
}
