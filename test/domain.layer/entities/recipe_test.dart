import 'package:food_app_flutter/domain.layer/entities/recipe.dart';
import 'package:test/test.dart';

import '../../fixtures/fixtures.dart';

void main() {
  group('Recipe', () {
    test('Two instances with the same properties should be equal', () {
      final recipe1 = anyRecipe1;
      final recipe2 = anyRecipe1;

      expect(recipe1, equals(recipe2));
    });

    test('Two instances with different properties should be different', () {
      final recipe1 = anyRecipe1;
      final recipe2 = anyRecipe2;

      expect(recipe1, isNot(equals(recipe2)));
    });
  });
}
