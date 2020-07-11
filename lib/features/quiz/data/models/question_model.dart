import 'package:meta/meta.dart';

import '../../domain/entities/question.dart';

class QuestionModel extends Question {
  QuestionModel({
    @required List<String> words,
    @required String word,
    @required int answer,
  }) : super(
          words: words,
          word: word,
          answer: answer,
        );
    
  factory QuestionModel.fromJson(Map jsonMap) {
    return QuestionModel(
      words: jsonMap["words"].cast<String>(),
      word: jsonMap["word"],
      answer: jsonMap["answer"],
    );
  }
}
