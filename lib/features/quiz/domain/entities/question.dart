import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Question extends Equatable {
  final List<String> words;
  final String word;
  final int answer;

  Question({
    @required this.words,
    @required this.word,
    @required this.answer,
  });

  @override
  List<Object> get props => [words, word, answer];
}
