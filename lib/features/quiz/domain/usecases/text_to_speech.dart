import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/quiz_repository.dart';

class GetTextToSpeechAudio extends UseCase<String, GetTextToSpeechAudioParams> {
  final QuizRepository repository;

  GetTextToSpeechAudio(this.repository);

  @override
  Future<Either<Failure, String>> call(
      GetTextToSpeechAudioParams params) async {
    return await repository.getTextToSpeechAudio(params.text);
  }
}

class GetTextToSpeechAudioParams {
  final String text;

  GetTextToSpeechAudioParams({@required this.text});
}
