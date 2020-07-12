import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class SettingsRepository {
  Future<Either<Failure, bool>> getTheme();
  Future<Either<Failure, bool>> setTheme(bool isDark);
}
