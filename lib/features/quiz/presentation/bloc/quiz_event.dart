part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List get props => [];
}

class SetStartPageEvent extends QuizEvent {}

class SetLanguageEvent extends QuizEvent {
  final Language language;

  SetLanguageEvent({@required this.language});
}

class GetQuestionEvent extends QuizEvent {}

class SelectAnswerEvent extends QuizEvent {
  final answerIndex;

  SelectAnswerEvent({@required this.answerIndex});
}

class SetLanguageFromDropdownEvent extends QuizEvent {
  final Language language;

  SetLanguageFromDropdownEvent({@required this.language});
}
