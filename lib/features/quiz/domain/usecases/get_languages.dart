import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/language.dart';
import '../repositories/quiz_repository.dart';

class GetLanguages extends UseCase<List<Language>, NoParams> {
  final QuizRepository repository;

  GetLanguages(this.repository);

  @override
  Future<Either<Failure, List<Language>>> call(NoParams params) async {
    return await repository.getLanguages();
  }
}
