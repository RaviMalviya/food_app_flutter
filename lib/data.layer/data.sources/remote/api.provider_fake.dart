import 'package:food_app_flutter/data.layer/util/file_manager.dart';
import '../../dto/recipe.dto.dart';
import '../api.provider.dart';

class ApiProviderFake implements ApiProvider {
  @override
  Future<List<RecipeDto>> getRecipe() async {
    return Future.delayed(const Duration(milliseconds: 2000), () async {
      final data = await FileManager.readJsonFile('files/get_recipe.json');
      List<RecipeDto> myList = RecipeDto.fromResponse(data);
      return myList;
    });
  }
}
