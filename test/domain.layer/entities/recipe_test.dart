import 'package:food_app_flutter/domain.layer/entities/recipe.dart';
import 'package:test/test.dart';

void main() {
  group('Recipe', () {
    test('Two instances with the same properties should be equal', () {
      final character1 = Recipe(
          id: "Homemade orange juice-01",
          name: 'Homemade orange juice',
          image: 'https://testurl.com',
          rating: 5,
          totalTime: "5 min");

      final character2 = Recipe(
          id: "Homemade orange juice-01",
          name: 'Homemade orange juice',
          image: 'https://testurl.com',
          rating: 5,
          totalTime: "5 min");

      expect(character1, equals(character2));
    });

    test('Two instances with different properties should be different', () {
      final character1 = Recipe(
          id: "Homemade maggie-1",
          name: 'Homemade maggie',
          image: 'https://testurl.com',
          rating: 5,
          totalTime: "5 min");

      final character2 = Recipe(
          id: "Homemade orange juice-01",
          name: 'Homemade orange juice',
          image: 'https://testurl.com',
          rating: 5,
          totalTime: "5 min");

      expect(character1, isNot(equals(character2)));
    });
  });
}
