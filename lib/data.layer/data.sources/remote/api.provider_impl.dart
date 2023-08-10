import 'dart:convert';
import 'package:food_app_flutter/core/error/exceptions.dart';

import '../../dto/recipe.dto.dart';
import '../api.provider.dart';
import 'package:http/http.dart' as http;

class ApiProviderImpl implements ApiProvider {
  final http.Client client;
  ApiProviderImpl({required this.client});

  @override
  Future<List<RecipeDto>> getRecipe() async {
    var params = {"limit": "18", "start": "0", "tag": "list.recipe.popular"};
    var headers = {
      "x-rapidapi-key": "a5b80308amsh3abe18ed5b25b2c17090ajsn8c5c85b5b088",
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "useQueryString": "true",
    };

    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list', params);
    final response = await client.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data == null) {
        throw InvalidOutputException();
      }
      return RecipeDto.fromResponse(data);
    } else {
      throw ServerException(response.statusCode);
    }
  }
}
