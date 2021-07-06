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

  final testDate = DateTime(2020, 03, 01);
  final testSpaceMediaModel = SpaceMediaModel(
    description:
        "What created this unusual hole in Mars? The hole was discovered by chance in 2011 on images of the dusty slopes of Mars' Pavonis Mons volcano taken by the HiRISE instrument aboard the robotic Mars Reconnaissance Orbiter currently circling Mars. The hole, shown in representative color, appears to be an opening to an underground cavern, partly illuminated on the image right.  Analysis of this and follow-up images revealed the opening to be about 35 meters across, while the interior shadow angle indicates that the underlying cavern is roughly 20 meters deep. Why there is a circular crater surrounding this hole remains a topic of speculation, as is the full extent of the underlying cavern. Holes such as this are of particular interest because their interior caves are relatively protected from the harsh surface of Mars, making them relatively good candidates to contain Martian life. These pits are therefore prime targets for possible future spacecraft, robots, and even human interplanetary explorers.",
    mediaType: "image",
    title: "A Hole in Mars",
    mediaUrl: "https://apod.nasa.gov/apod/image/2003/marshole2r_hirise_960.jpg",
  );

  test('Should return a spacMediaModel When  calls the datasource', () async {
    when(() => dataSource.getSpaceMediaFromDate(testDate)).thenAnswer((_) async => testSpaceMediaModel);

    final spaceMediaFound = await repositorySpaceMedia.getSpaceMediaFromDate(testDate);
    expect(spaceMediaFound, Right(testSpaceMediaModel));
    verify(() => dataSource.getSpaceMediaFromDate(testDate));
  });

  test('Should return a server Failuere when the call to datasource is unsucessful', () async {
    when(() => dataSource.getSpaceMediaFromDate(testDate)).thenThrow(ServerException());

    final spaceMediaFound = await repositorySpaceMedia.getSpaceMediaFromDate(testDate);
    expect(spaceMediaFound, Left(ServerFailure()));
    verify(() => dataSource.getSpaceMediaFromDate(testDate));
  });
}
