import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_code_app/core/errors/failures.dart';

import 'package:nasa_clean_code_app/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_code_app/features/domain/repositories/space_media_repository.dart';
import 'package:nasa_clean_code_app/features/domain/usecases/get_space_media_usecase.dart';

class MockSpaceMediaRepository extends Mock implements SpaceMediaRepository {}

void main() {
  late GetSpaceMediaFromDateUseCase usecase;
  late SpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaFromDateUseCase(repository);
  });

  final testDate = DateTime(1993, 03, 01);
  final testSpaceMedia = SpaceMediaEntity(description: "michael", mediaType: "", title: "title", mediaUrl: "mediaUrl");
  test('Should get space media for a given dae from the repository', () async {
    when(() => repository.getSpaceMediaFromDate(testDate)).thenAnswer((_) async => Right(testSpaceMedia));
    final spaceMediaFound = await usecase(testDate);
    expect(spaceMediaFound, Right(testSpaceMedia));
    verify(() => repository.getSpaceMediaFromDate(testDate));
  });

  test('Should return a ServerFailure when don\'t succeed', () async {
    when(() => repository.getSpaceMediaFromDate(testDate)).thenAnswer((_) async => Left(ServerFailure()));
    final spaceMediaFound = await usecase(testDate);
    expect(spaceMediaFound, Left(ServerFailure()));
    verify(() => repository.getSpaceMediaFromDate(testDate));
  });
}
