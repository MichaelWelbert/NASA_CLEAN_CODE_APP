import 'dart:convert';

import 'package:nasa_clean_code_app/core/errors/exceptions.dart';
import 'package:nasa_clean_code_app/core/utils/converters/date_to_string_converters.dart';
import 'package:nasa_clean_code_app/core/utils/keys/nasa_api_keys.dart';
import 'package:nasa_clean_code_app/features/data/datasources/endpoints/nasa_endpoints.dart';
import 'package:nasa_clean_code_app/features/data/datasources/http_client.dart/http_client.dart';
import 'package:nasa_clean_code_app/features/data/model/space_media_model.dart';
import 'package:nasa_clean_code_app/features/data/repositories/space_media_data_source.dart';

class SpaceMediaDataSourceImplementation implements SpaceMediaDataSource {
  final HttpClient client;

  SpaceMediaDataSourceImplementation({required this.client});
  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    final response = await client.get(NasaEndpoints.apod(NasaApiKeys.apiKey(), DateToStringConverter.convert(date)));
    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(jsonDecode(response.data));
    } else {
      throw ServerException();
    }
  }
}
