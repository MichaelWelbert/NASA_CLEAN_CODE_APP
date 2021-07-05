import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_clean_code_app/features/data/model/space_media_model.dart';
import 'package:nasa_clean_code_app/features/domain/entities/space_media_entity.dart';

import '../../../mocks/space_media_mock.dart';

void main() {
  final testSpaceMediaModel = SpaceMediaModel(
    description:
        "The Pelican Nebula is changing.   The entire nebula, officially designated IC 5070, is divided from the larger North America Nebula by a molecular cloud filled with dark dust.  The Pelican, however, is particularly interesting because it is an unusually active mix of star formation and evolving gas clouds.  The featured picture was processed to bring out two main colors, red and blue, with the red dominated by light emitted by interstellar hydrogen. Ultraviolet light emitted by young energetic stars is slowly transforming cold gas in the nebula to hot gas, with the advancing boundary between the two, known as an ionization front, visible in bright red across the image center. Particularly dense tentacles of cold gas remain.  Millions of years from now this nebula might no longer be known as the Pelican, as the balance and placement of stars and gas will surely leave something that appears completely different.   APOD in world languages: Arabic, Bulgarian, Catalan, Chinese (Beijing), Chinese (Taiwan), Croatian, Czech, Dutch, Farsi, French, German, Hebrew, Indonesian, Korean, Montenegrin, Polish, Russian, Serbian, Slovenian,  Spanish, Taiwanese, Turkish, Turkish, and  Ukrainian",
    mediaType: "image",
    title: "The Pelican Nebula in Red and Blue",
    mediaUrl: "https://apod.nasa.gov/apod/image/2102/Pelican_PetraskoEtAl_960.jpg",
  );

  test('Should be a subclass of SpaceMediaEntity', () {
    expect(testSpaceMediaModel, isA<SpaceMediaEntity>());
  });

  test('should return a valid model when to send a json', () {
    final Map<String, dynamic> jsonMapSpaceMediaMock = json.decode(spaceMediaMock);
    final spaceMediaFound = SpaceMediaModel.fromJson(jsonMapSpaceMediaMock);
    expect(spaceMediaFound, jsonMapSpaceMediaMock);
  });
}
