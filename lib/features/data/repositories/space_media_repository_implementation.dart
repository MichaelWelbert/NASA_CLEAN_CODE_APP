import 'package:nasa_clean_code_app/core/errors/exceptions.dart';
import 'package:nasa_clean_code_app/features/data/repositories/space_media_data_source.dart';
import 'package:nasa_clean_code_app/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_code_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:nasa_clean_code_app/features/domain/repositories/space_media_repository.dart';

class SpaceMediaRepositoryImplementation implements SpaceMediaRepository {
  final SpaceMediaDataSource dataSource;

  SpaceMediaRepositoryImplementation(this.dataSource);
  @override
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(DateTime date) async {
    try {
      final result = await dataSource.getSpaceMediaFromDate(date);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
