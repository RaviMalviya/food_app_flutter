import 'package:food_app_flutter/domain.layer/entities/recipe.dart';
import 'package:test/test.dart';

void main() {
  group('Recipe', () {
    test('Two instances with the same properties should be equal', () {
      final recipe1 = Recipe(
          id: "Homemade orange juice-01",
          name: 'Homemade orange juice',
          image: 'https://testurl.com',
          rating: 5,
          totalTime: "5 min");

      final recipe2 = Recipe(
          id: "Homemade orange juice-01",
          name: 'Homemade orange juice',
          image: 'https://testurl.com',
          rating: 5,
          totalTime: "5 min");

      expect(recipe1, equals(recipe2));
    });

    test('Two instances with different properties should be different', () {
      final recipe1 = Recipe(
          id: "Homemade maggie-1",
          name: 'Homemade maggie',
          image: 'https://testurl.com',
          rating: 5,
          totalTime: "5 min");

      final recipe2 = Recipe(
          id: "Homemade orange juice-01",
          name: 'Homemade orange juice',
          image: 'https://testurl.com',
          rating: 5,
          totalTime: "5 min");

      expect(recipe1, isNot(equals(recipe2)));
    });
  });
}
