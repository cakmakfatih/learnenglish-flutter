import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/language.dart';
import '../entities/question.dart';
import '../repositories/quiz_repository.dart';

class GetQuestion extends UseCase<Question, GetQuestionParams> {
  final QuizRepository repository;

  GetQuestion(this.repository);

  @override
  Future<Either<Failure, Question>> call(GetQuestionParams params) async {
    return await repository.getQuestion(params.language);
  }
}

class GetQuestionParams {
  final Language language;

  GetQuestionParams({@required this.language});
}
