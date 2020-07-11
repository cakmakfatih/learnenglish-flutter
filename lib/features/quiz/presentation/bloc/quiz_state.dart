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

  QuizMain({
    @required this.language,
    @required this.languages,
    this.question,
    this.isLoading: false,
    this.selectedAnswerIndex,
  });

  QuizMain copyWith({
    Language language,
    List<Language> languages,
    Question question,
    bool isLoading,
    int selectedAnswerIndex,
  }) {
    return QuizMain(
      language: language ?? this.language,
      languages: languages ?? this.languages,
      question: question ?? this.question,
      isLoading: isLoading,
      selectedAnswerIndex: selectedAnswerIndex,
    );
  }

  @override
  List<Object> get props =>
      [language, languages, question, isLoading, selectedAnswerIndex];
}
