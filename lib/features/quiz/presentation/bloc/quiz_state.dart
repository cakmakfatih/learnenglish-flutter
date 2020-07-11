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
