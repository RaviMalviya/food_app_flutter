import 'package:food_app_flutter/data.layer/dto/recipe.dto.dart';
import 'package:test/test.dart';

void main() {
  group('RecipeDto', () {
    late String referenceRawJson;
    late RecipeDto referenceDto;

    setUp(() {
      referenceDto = RecipeDto(
        id: 'Homemade strawberry-001',
        name: "Homemade strawberry",
        image: "https://testurl.com",
        rating: 4,
        totalTime: '5 Min',
      );

      referenceRawJson = referenceDto.toRawJson();
    });

    test('should create RecipeDto instance to/from JSON', () {
      final apiReferenceRawJson = "{\"id\":\"${referenceDto.id}\",\"name\":\"${referenceDto.name}\",\"images\":[{\"hostedLargeUrl\": \"${referenceDto.image}\"}],\"rating\":${referenceDto.rating}, \"totalTime\": \"${referenceDto.totalTime}\"}";
      final createdDto = RecipeDto.fromRawJson(apiReferenceRawJson);
      final json = createdDto.toRawJson();
      expect(createdDto, referenceDto);
      expect(json, referenceRawJson);
    });
  });
}
