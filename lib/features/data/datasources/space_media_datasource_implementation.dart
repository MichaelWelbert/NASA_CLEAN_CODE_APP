import 'package:nasa_clean_code_app/features/data/datasources/http_client.dart/http_client.dart';
import 'package:nasa_clean_code_app/features/data/model/space_media_model.dart';
import 'package:nasa_clean_code_app/features/data/repositories/space_media_data_source.dart';

class SpaceMediaDataSourceImplementation implements SpaceMediaDataSource {
  final HttpClient client;

  SpaceMediaDataSourceImplementation({required this.client});
  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) {
    // TODO: implement getSpaceMediaFromDate
    throw UnimplementedError();
  }
}
