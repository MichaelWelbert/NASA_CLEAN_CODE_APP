import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_code_app/core/errors/exceptions.dart';
import 'package:nasa_clean_code_app/features/data/datasources/http_client.dart/http_client.dart';
import 'package:nasa_clean_code_app/features/data/datasources/space_media_datasource_implementation.dart';
import 'package:nasa_clean_code_app/features/data/model/space_media_model.dart';
import 'package:nasa_clean_code_app/features/data/repositories/space_media_data_source.dart';

import '../../../mocks/space_media_mock.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late SpaceMediaDataSource datasource;
  late HttpClient client;

  setUp(() {
    client = HttpClientMock();
    datasource = SpaceMediaDataSourceImplementation(client: client);
  });

  final int successStatusCode = 200;
  final testDate = DateTime(2020, 03, 01);
  final urlExpected = 'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2020-03-01';

  test('should call the get method with correct url', () async {
    when(() => client.get(any())).thenAnswer((_) async => HttpResponse(data: spaceMediaMock, statusCode: successStatusCode));

    await datasource.getSpaceMediaFromDate(testDate);

    verify(() => client.get(urlExpected)).called(1);
  });

  test('should return a spaceMediaModel when is successful', () async {
    when(() => client.get(any())).thenAnswer((_) async => HttpResponse(data: spaceMediaMock, statusCode: successStatusCode));
    final testSpaceMediaModelExpected = SpaceMediaModel(
      description:
          "What created this unusual hole in Mars? The hole was discovered by chance in 2011 on images of the dusty slopes of Mars' Pavonis Mons volcano taken by the HiRISE instrument aboard the robotic Mars Reconnaissance Orbiter currently circling Mars. The hole, shown in representative color, appears to be an opening to an underground cavern, partly illuminated on the image right.  Analysis of this and follow-up images revealed the opening to be about 35 meters across, while the interior shadow angle indicates that the underlying cavern is roughly 20 meters deep. Why there is a circular crater surrounding this hole remains a topic of speculation, as is the full extent of the underlying cavern. Holes such as this are of particular interest because their interior caves are relatively protected from the harsh surface of Mars, making them relatively good candidates to contain Martian life. These pits are therefore prime targets for possible future spacecraft, robots, and even human interplanetary explorers.",
      mediaType: "image",
      title: "A Hole in Mars",
      mediaUrl: "https://apod.nasa.gov/apod/image/2003/marshole2r_hirise_960.jpg",
    );

    final spaceMediaFound = await datasource.getSpaceMediaFromDate(testDate);

    expect(spaceMediaFound, testSpaceMediaModelExpected);
  });

  final int anyFailStatusCode = 400;
  test('should throw a ServerException when the call is uncessful', () async {
    when(() => client.get(any())).thenAnswer((_) async => HttpResponse(data: 'something went wrong', statusCode: anyFailStatusCode));

    final spaceMediaFound = datasource.getSpaceMediaFromDate(testDate);

    expect(() => spaceMediaFound, throwsA(ServerException()));
  });
}
