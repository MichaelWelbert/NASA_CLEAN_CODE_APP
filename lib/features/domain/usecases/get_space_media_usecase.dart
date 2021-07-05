import 'package:nasa_clean_code_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:nasa_clean_code_app/core/usecase/usecase.dart';
import 'package:nasa_clean_code_app/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_code_app/features/domain/repositories/space_media_repository.dart';

class GetSpaceMediaFromDateUseCase implements UseCase<SpaceMediaEntity, DateTime> {
  final SpaceMediaRepository spaceMediaRepository;

  GetSpaceMediaFromDateUseCase(this.spaceMediaRepository);

  @override
  Future<Either<Failure, SpaceMediaEntity>> call(DateTime date) async {
    return await spaceMediaRepository.getSpaceMediaFromDate(date);
  }
}
