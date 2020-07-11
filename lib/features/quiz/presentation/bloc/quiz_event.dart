part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List get props => [];
}

class SetStartPageEvent extends QuizEvent {}
