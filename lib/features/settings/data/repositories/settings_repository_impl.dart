import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_data_source.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl({
    @required this.localDataSource,
  });

  @override
  Future<Either<Failure, bool>> getTheme() async {
    try {
      final themeIsDark = await localDataSource.getTheme();

      return Right(themeIsDark);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> setTheme(bool isDark) async {
    return Right(await localDataSource.setTheme(isDark));
  }
}
