
import 'package:dartz/dartz.dart';
import 'package:food_app_flutter/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}