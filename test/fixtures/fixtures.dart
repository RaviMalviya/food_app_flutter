import 'package:food_app_flutter/data.layer/dto/recipe.dto.dart';
import 'package:food_app_flutter/domain.layer/entities/recipe.dart';

final anyRecipe1 = Recipe(
    id: "Homemade maggie-1",
    name: 'Homemade maggie',
    image: 'https://maggie-testurl.com',
    rating: 5,
    totalTime: "5 min");

final anyRecipe2 = Recipe(
    id: "Homemade maggie-2",
    name: 'Homemade maggie',
    image: 'https://maggie-testurl.com',
    rating: 5,
    totalTime: "5 min");

final List<Recipe> anyRecipes1 = [
  Recipe(
      id: "Homemade maggie-1",
      name: 'Homemade maggie',
      image: 'https://maggie-testurl.com',
      rating: 5,
      totalTime: "5 min"),
  Recipe(
      id: "Homemade maggie-2",
      name: 'Homemade maggie',
      image: 'https://maggie-testurl.com',
      rating: 5,
      totalTime: "5 min")
];

final anyRecipeDto1 = RecipeDto(
    id: "Homemade maggie-1",
    name: 'Homemade maggie',
    image: 'https://maggie-testurl.com',
    rating: 5,
    totalTime: "5 min");

const anyRecipeDto1RawJson =
    "{\"id\":\"Homemade maggie-1\",\"name\":\"Homemade maggie\",\"images\":[{\"hostedLargeUrl\": \"https://maggie-testurl.com\"}],\"rating\":5, \"totalTime\": \"5 min\"}";

final anyRecipeDto2 = RecipeDto(
    id: "Homemade maggie-2",
    name: 'Homemade maggie',
    image: 'https://maggie-testurl.com',
    rating: 5,
    totalTime: "5 min");
