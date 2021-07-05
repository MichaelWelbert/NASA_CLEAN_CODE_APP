import 'package:nasa_clean_code_app/features/data/model/space_media_model.dart';

abstract class SpaceMediaDataSource {
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date);
}
