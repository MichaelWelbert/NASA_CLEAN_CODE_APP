import 'package:dartz/dartz.dart';
import 'package:nasa_clean_code_app/core/errors/failures.dart';
import 'package:nasa_clean_code_app/features/domain/entities/space_media_entity.dart';

abstract class SpaceMediaRepository {
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(DateTime date);
}
