import 'package:food_app_flutter/data.layer/dto/recipe.dto.dart';

abstract class ApiProvider {
  Future<List<RecipeDto>> getRecipe() async {
    throw UnimplementedError();
  }
}