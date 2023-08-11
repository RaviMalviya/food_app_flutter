import 'package:food_app_flutter/data.layer/dto/recipe.dto.dart';
import 'package:test/test.dart';

import '../../fixtures/fixtures.dart';

void main() {
  group('RecipeDto', () {
    late String referenceRawJson;
    late RecipeDto referenceDto;

    setUp(() {
      referenceDto = anyRecipeDto1;
      referenceRawJson = referenceDto.toRawJson();
    });

    test('should create RecipeDto instance to/from JSON', () {
      const apiReferenceRawJson = anyRecipeDto1RawJson;
      final createdDto = RecipeDto.fromRawJson(apiReferenceRawJson);
      final json = createdDto.toRawJson();
      expect(createdDto, referenceDto, reason: 'model is not same');
      expect(json, referenceRawJson, reason: 'json string is not same');
    });
  });
}
