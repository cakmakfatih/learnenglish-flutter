import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/settings_repository.dart';

class SetTheme extends UseCase<bool, SetThemeParams> {
  final SettingsRepository repository;

  SetTheme(this.repository);

  @override
  Future<Either<Failure, bool>> call(SetThemeParams params) async {
    return await repository.setTheme(params.isDark);
  }
}

class SetThemeParams {
  final bool isDark;

  SetThemeParams({this.isDark});
}
