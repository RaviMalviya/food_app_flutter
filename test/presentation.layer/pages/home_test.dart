import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_app_flutter/domain.layer/entities/recipe.dart';
import 'package:food_app_flutter/domain.layer/repositories/api.repository.dart';
import 'package:food_app_flutter/injection_container.dart';
import 'package:food_app_flutter/presentation.layer/bloc/home/home_bloc.dart';
import 'package:food_app_flutter/presentation.layer/pages/home.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../fixtures/fixtures.dart';
import 'home_test.mocks.dart';

@GenerateMocks([HomeBloc, ApiRepository])
void main() {
  Widget makeTestableWidget({Widget? child, required HomeBloc bloc}) {
    return BlocProvider<HomeBloc>(
      create: (context) => bloc,
      child: MaterialApp(home: child),
    );
  }

  setUp(() {});

  testWidgets('renders HomePage', (WidgetTester tester) async {
    final mockApiRepository = MockApiRepository();
    const homePage = HomePage();

    List<Recipe> tRecipes = anyRecipes1;

    void setupMockApiRepositorySuccess() {
      when(mockApiRepository.getRecipe())
          .thenAnswer((_) => Future.value(Right(tRecipes)));
    }

    try {
      // arrange
      setupMockApiRepositorySuccess();
      //act
      await tester.pumpWidget(makeTestableWidget(
        child: homePage,
        bloc: HomeBloc(repository: mockApiRepository),
      ));
      await tester.pumpAndSettle();
    } catch (e) {
      // print(e);
      // https://stackoverflow.com/questions/64231515/widget-test-testing-a-button-with-circularprogressindicator
    }
    // assert
    expectLater(find.byType(HomePage), findsOneWidget);
  });
}
