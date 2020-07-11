import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/language.dart';
import '../repositories/quiz_repository.dart';

class GetLanguage extends UseCase<Language, NoParams> {
  final QuizRepository repository;

  GetLanguage(this.repository);

  @override
  Future<Either<Failure, Language>> call(NoParams params) async {
    return await repository.getLanguage();
  }
}
