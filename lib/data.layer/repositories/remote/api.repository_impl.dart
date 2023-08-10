import 'package:dartz/dartz.dart';
import 'package:food_app_flutter/core/error/exceptions.dart';
import 'package:food_app_flutter/core/util/export.dart';
import 'package:food_app_flutter/data.layer/data.sources/api.provider.dart';
import '../../../core/error/failures.dart';
import '../../../core/network/network_info.dart';
import '../../../domain.layer/entities/recipe.dart';
import '../../../domain.layer/repositories/api.repository.dart';

class ApiRepositoryImpl implements ApiRepository {
  /*
     ApiRepository._internal();
     static final ApiRepository _apiRepository = ApiRepository._internal();
     factory ApiRepository() => _apiRepository;
  */

  final NetworkInfo networkInfo;
  final ApiProvider provider; // ApiProviderImpl or ApiProviderFake
  ApiRepositoryImpl({required this.networkInfo, required this.provider});

  @override
  Future<Either<Failure, List<Recipe>>> getRecipe() async {
    if (await networkInfo.isConnected == false) {
      return Left(NoInternetFailure());
    }
    try {
      var result = await provider.getRecipe();
      return Right(result);
    } on Exception catch (err) {
      safePrint(err);
      return Left(exceptionToFailureMapper(err));
    } catch (err) {
      safePrint(err);
      return Left(UnknownFailure());
    }
  }

  Failure exceptionToFailureMapper(Exception err) {
    if (err is NoInternetException) {
      return NoInternetFailure();
    } else if (err is ServerException) {
      return ServerFailure();
    } else if (err is InvalidInputException) {
      return InvalidInputFailure();
    } else if (err is InvalidOutputException) {
      return InvalidOutputFailure();
    } else {
      return UnknownFailure();
    }
  }
}
