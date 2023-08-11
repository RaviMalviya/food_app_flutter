import 'package:equatable/equatable.dart';

class Recipe with EquatableMixin {
  final String id;
  final String name;
  final String image;
  final int rating;
  final String totalTime;

  Recipe({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.totalTime,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        rating,
        totalTime,
      ];
}
