import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_code_app/features/data/datasources/http_client.dart/http_client.dart';
import 'package:nasa_clean_code_app/features/data/datasources/space_media_datasource_implementation.dart';
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
  test('should call the get method with correct url', () async {
    when(() => client.get(any())).thenAnswer((_) async => HttpResponse(data: spaceMediaMock, statusCode: successStatusCode));
  });
}
