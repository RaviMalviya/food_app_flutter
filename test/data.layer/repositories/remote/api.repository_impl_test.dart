import 'package:dartz/dartz.dart';
import 'package:food_app_flutter/core/error/exceptions.dart';
import 'package:food_app_flutter/core/error/failures.dart';
import 'package:food_app_flutter/core/network/network_info.dart';
import 'package:food_app_flutter/data.layer/data.sources/api.provider.dart';
import 'package:food_app_flutter/data.layer/dto/recipe.dto.dart';
import 'package:food_app_flutter/data.layer/repositories/remote/api.repository_impl.dart';
import 'package:food_app_flutter/domain.layer/entities/recipe.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'api.repository_impl_test.mocks.dart';

@GenerateMocks([ApiProvider, NetworkInfo])

void main() {
  late ApiRepositoryImpl repositoryImpl;
  late MockNetworkInfo mockNetworkInfo;
  late MockApiProvider mockApiProvider;
  // late FakeRecipeDto fakeRecipeDto;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockApiProvider = MockApiProvider();
    repositoryImpl = ApiRepositoryImpl(
        networkInfo: mockNetworkInfo, provider: mockApiProvider);
  });

  runTestIsOnline(bool isOnline, Function body) {
    final online = isOnline ? 'online' : 'offline';
    group('device is $online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((_) => Future.value(isOnline));
      });
      body();
    });
  }

  group('getRecipe', () {
    final List<RecipeDto> tRecipeDtoList = [
      RecipeDto(
          id: '1',
          name: 'Homemade fruit salad',
          image: 'https://testurl.com',
          rating: 4,
          totalTime: '2 min')
    ];
    final List<Recipe> tRecipeList = tRecipeDtoList; //lisvoke substitute

    test('isConnected, should check device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) => Future.value(true));
      when(mockApiProvider.getRecipe())
          .thenAnswer((_) => Future.value(tRecipeDtoList));
      //act
      await repositoryImpl.getRecipe();
      //assert
      verify(mockNetworkInfo.isConnected); //method invoke previously on act.
    });

    runTestIsOnline(true, () {
      test('getRecipe, should return remote data successful', () async {
        //arrange - if act method inside have this method call then return will be tRecipeDtoList
        when(mockApiProvider.getRecipe())
            .thenAnswer((_) => Future.value(tRecipeDtoList));
        //act
        final result = await repositoryImpl.getRecipe();
        //assert
        verify(mockApiProvider.getRecipe());
        expect(result, equals(Right(tRecipeList)));
      });

      test('getRecipe, should return server failure', () async {
        //arrange
        when(mockApiProvider.getRecipe())
            .thenAnswer((_) => throw ServerException(400));
        //act
        final result = await repositoryImpl.getRecipe();
        //assert
        verify(mockApiProvider.getRecipe());
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestIsOnline(false, () {
      test('getRecipe, should return no internet failure', () async {
        //arrange
        // already done by runTestIsOnline set param false
        //act
        final result = await repositoryImpl.getRecipe();
        //assert
        expect(result, equals(Left(NoInternetFailure())));
      });
    });
  });
}
