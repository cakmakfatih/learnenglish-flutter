import '../error/failures.dart';
import 'constants.dart';

String mapFailureToMessage(Failure failure) {
  if (failure is ServerFailure)
    return SERVER_FAILURE_MESSAGE;
  else if (failure is CacheFailure)
    return CACHE_FAILURE_MESSAGE;
  else if (failure is ConnectionFailure) return CONNECTION_FAILURE_MESSAGE;

  return UNEXPECTED_FAILURE_MESSAGE;
}
