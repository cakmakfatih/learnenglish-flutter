import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/question.dart';
import '../repositories/quiz_repository.dart';

class GetQuestion extends UseCase<Question, NoParams> {
  final QuizRepository repository;

  GetQuestion(this.repository);

  @override
  Future<Either<Failure, Question>> call(NoParams params) async {
    return await repository.getQuestion();
  }
}
