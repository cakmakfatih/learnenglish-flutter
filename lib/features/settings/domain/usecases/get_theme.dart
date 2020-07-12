import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/settings_repository.dart';

class GetTheme extends UseCase<bool, NoParams> {
  final SettingsRepository repository;

  GetTheme(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.getTheme();
  }
}
