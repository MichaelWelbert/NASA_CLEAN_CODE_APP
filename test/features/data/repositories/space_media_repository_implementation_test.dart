import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_code_app/core/errors/exceptions.dart';
import 'package:nasa_clean_code_app/core/errors/failures.dart';
import 'package:nasa_clean_code_app/features/data/model/space_media_model.dart';
import 'package:nasa_clean_code_app/features/data/repositories/space_media_data_source.dart';
import 'package:nasa_clean_code_app/features/data/repositories/space_media_repository_implementation.dart';
import 'package:nasa_clean_code_app/features/domain/repositories/space_media_repository.dart';

class MockSpaceMediaDataSource extends Mock implements SpaceMediaDataSource {}

void main() {
  late SpaceMediaRepository repositorySpaceMedia;
  late SpaceMediaDataSource dataSource;

  setUp(() {
    dataSource = MockSpaceMediaDataSource();
    repositorySpaceMedia = SpaceMediaRepositoryImplementation(dataSource);
  });

  final testDate = DateTime(1993, 03, 01);
  final testSpaceMediaModel = SpaceMediaModel(description: "michael", mediaType: "", title: "title", mediaUrl: "mediaUrl");

  test('Should return a spacMediaModel When  calls the datasource', () async {
    when(() => dataSource.getSpaceMediaFromDate(testDate)).thenAnswer((_) async => testSpaceMediaModel);

    final spaceMediaFound = await repositorySpaceMedia.getSpaceMediaFromDate(testDate);
    expect(spaceMediaFound, Right(testSpaceMediaModel));
    verify(() => dataSource.getSpaceMediaFromDate(testDate));
  });

  test('Should return a server Failuere when the call to datasource is unsucessful', () async {
    when(() => dataSource.getSpaceMediaFromDate(testDate)).thenThrow((_) async => ServerException());

    final spaceMediaFound = await repositorySpaceMedia.getSpaceMediaFromDate(testDate);
    expect(spaceMediaFound, Left(ServerFailure()));
    verify(() => dataSource.getSpaceMediaFromDate(testDate));
  });
}
