
import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/recipe.dart';

abstract class ApiRepository {
  Future<Either<Failure, List<Recipe>>> getRecipe() async {
    throw UnimplementedError();
  }
}