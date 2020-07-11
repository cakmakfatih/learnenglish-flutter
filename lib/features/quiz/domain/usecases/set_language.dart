import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/language.dart';
import '../repositories/quiz_repository.dart';

class SetLanguage extends UseCase<bool, SetLanguageParams> {
  final QuizRepository repository;

  SetLanguage(this.repository);

  @override
  Future<Either<Failure, bool>> call(SetLanguageParams params) async {
    return await repository.setLanguage(params.language);
  }
}

class SetLanguageParams {
  final Language language;

  SetLanguageParams({@required this.language});
}
