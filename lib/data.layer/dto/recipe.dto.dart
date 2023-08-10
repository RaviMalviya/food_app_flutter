import 'dart:convert';
import '../../domain.layer/entities/recipe.dart';

class RecipeDto extends Recipe {
  RecipeDto({
    required super.id,
    required super.name,
    required super.image,
    required super.rating,
    required super.totalTime,
  });

  // ---------------------------------------------------------------------------
  // JSON
  // ---------------------------------------------------------------------------
  factory RecipeDto.fromRawJson(String str) =>
      RecipeDto.fromMap(json.decode(str));

  String toRawJson() => json.encode(toMap());

  // ---------------------------------------------------------------------------
  // Maps
  // ---------------------------------------------------------------------------

  factory RecipeDto.fromMap(Map<String, dynamic> json) => RecipeDto(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        image: json['images']?[0]?['hostedLargeUrl'] as String? ?? '',
        rating: json['rating'] as int? ?? 0,
        totalTime: json['totalTime'] as String? ?? '',
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "image": image,
        "rating": rating,
        "totalTime": totalTime,
      };

  // ---------------------------------------------------------------------------
  // Helper Methods
  // ---------------------------------------------------------------------------

  static List<RecipeDto> fromResponse(Map data) {
    List list = [];
    final feeds = data['feed'];
    feeds?.asMap().forEach((index, item) {
      final json = item['content']['details'];
      if (json != null && index <= 19) {
        list.add(json);
      }
    });
    var models = list.map((json) {
      var model = RecipeDto.fromMap(json);
      if (model.name.isEmpty || model.image.isEmpty) {
        return null;
      } else {
        return model;
      }
    });
    List<RecipeDto> notNullModels =
        models.where((element) => (element != null)).toList().cast<RecipeDto>();
    return notNullModels;
  }
}
