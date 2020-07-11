import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/language.dart';
import '../entities/question.dart';

abstract class QuizRepository {
  Future<Either<Failure, bool>> setLanguage(Language language);
  Future<Either<Failure, Question>> getQuestion(Language language);
  Future<Either<Failure, List<Language>>> getLanguages();
  Future<Either<Failure, Language>> getLanguage();
}
