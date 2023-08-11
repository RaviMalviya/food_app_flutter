import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_app_flutter/core/error/failures.dart';
import 'package:food_app_flutter/domain.layer/entities/recipe.dart';
import 'package:food_app_flutter/domain.layer/repositories/api.repository.dart';
import 'package:food_app_flutter/presentation.layer/bloc/home/home_bloc.dart';
import 'package:food_app_flutter/presentation.layer/ui.util/error.message.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../fixtures/fixtures.dart';
import 'home_bloc_test.mocks.dart';

@GenerateMocks([ApiRepository])
void main() {
  late MockApiRepository mockApiRepository;
  late HomeBloc bloc;
  setUp(() {
    mockApiRepository = MockApiRepository();
    bloc = HomeBloc(repository: mockApiRepository);
  });

  test('initial state is correct', () {
    expect(bloc.state, equals(HomeInitial()));
  });

  group('GetRecipeEvent', () {
    List<Recipe> tRecipes = anyRecipes1;

    void setupMockApiRepositorySuccess() {
      when(mockApiRepository.getRecipe())
          .thenAnswer((_) => Future.value(Right(tRecipes)));
    }

    test(
        'bloc should invoke getRecipe from mockApiRepository when send GetRecipeEvent',
        () async {
      // Arrange: Stubbing
      setupMockApiRepositorySuccess();

      //action
      bloc.add(GetRecipeEvent());
      await untilCalled(mockApiRepository.getRecipe());

      //assert
      verify(mockApiRepository.getRecipe());
    });

    test('bloc should emit error when getRecipe gave no internet failure',
        () async {
      // Arrange: Stubbing
      when(mockApiRepository.getRecipe())
          .thenAnswer((_) => Future.value(Left(NoInternetFailure())));

      //assert Later
      final expectedStates = [
        HomeLoading(),
        ShowSnackBar(message: ErrorMessage.noInternet.text),
        HomeError(message: 'No Record Found')
      ];
      expectLater(bloc.stream, emitsInOrder(expectedStates));

      //action
      bloc.add(GetRecipeEvent());
    });

    test('bloc should emit error when getRecipe gave server failure',
            () async {
          // Arrange: Stubbing
          when(mockApiRepository.getRecipe())
              .thenAnswer((_) => Future.value(Left(ServerFailure())));

          //assert Later
          final expectedStates = [
            HomeLoading(),
            ShowSnackBar(message: ErrorMessage.server.text),
            HomeError(message: 'No Record Found')
          ];
          expectLater(bloc.stream, emitsInOrder(expectedStates));

          //action
          bloc.add(GetRecipeEvent());
        });
  });
}
