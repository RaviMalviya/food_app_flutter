import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_app_flutter/core/util/export.dart';
import 'package:food_app_flutter/domain.layer/entities/recipe.dart';
import 'package:food_app_flutter/domain.layer/repositories/api.repository.dart';
import 'package:food_app_flutter/presentation.layer/bloc/home/home_bloc.dart';
import 'package:food_app_flutter/presentation.layer/pages/home.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart' as mockito;
import '../../fixtures/fixtures.dart';
import 'package:mocktail/mocktail.dart' as mocktail;
import 'package:bloc_test/bloc_test.dart';

import '../bloc/home/home_bloc_test.mocks.dart';

@GenerateMocks([HomeBloc, ApiRepository])

class HomeBlocMock extends MockBloc<HomeEvent, HomeState>
    implements HomeBloc {}

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
      mockito.when(mockApiRepository.getRecipe())
          .thenAnswer((_) => Future.value(Right(tRecipes)));
    }

    try {
      // arrange
      setupMockApiRepositorySuccess();
      //act
      await tester.pumpWidget(makeTestableWidget(
        child: homePage,
        bloc: HomeBloc(repository: mockApiRepository)..add(GetRecipeEvent()),
      ));
      // await tester.pumpAndSettle();
    } catch (e) {
      // safePrint(e);
      // https://stackoverflow.com/questions/64231515/widget-test-testing-a-button-with-circularprogressindicator
    }
    // assert
    expectLater(find.byType(HomePage), findsOneWidget);
    expectLater(find.byWidget(homePage), findsOneWidget);
  });

  testWidgets('renders HomeLoading State', (WidgetTester tester) async {
    const homePage = HomePage();
    final homeBloc = HomeBlocMock();
    try {
      // arrange
      mocktail.when(() => homeBloc.state).thenReturn(HomeLoadingState());
      //act
      await tester.pumpWidget(makeTestableWidget(
        child: homePage,
        bloc: homeBloc,
      ));
    } catch (e) {
      safePrint(e);
    }
    // assert
    expect(find.byKey(const Key('centered_loading')), findsOneWidget);
    expect(find.byType(CenteredLoading), findsOneWidget);
  });

  testWidgets('renders HomeError State when ', (WidgetTester tester) async {
    const homePage = HomePage();
    final homeBloc = HomeBlocMock();
    try {
      // arrange
      mocktail.when(() => homeBloc.state).thenReturn(HomeInitialState());
      //act
      await tester.pumpWidget(makeTestableWidget(
        child: homePage,
        bloc: homeBloc,
      ));
    } catch (e) {
      safePrint(e);
    }
    // assert
    expect(find.byKey(const Key('centered_message')), findsOneWidget);
    expect(find.byType(CenteredMessage), findsOneWidget);
    expect(find.text('Initializing User Interface'), findsOneWidget);
  });

  testWidgets('renders HomeError State when No Record Found', (WidgetTester tester) async {
    const homePage = HomePage();
    final homeBloc = HomeBlocMock();
    try {
      // arrange
      mocktail.when(() => homeBloc.state).thenReturn(HomeErrorState(message: 'No Record Found'));
      //act
      await tester.pumpWidget(makeTestableWidget(
        child: homePage,
        bloc: homeBloc,
      ));
    } catch (e) {
      safePrint(e);
    }
    // assert
    expect(find.byKey(const Key('centered_message')), findsOneWidget);
    expect(find.byType(CenteredMessage), findsOneWidget);
    expect(find.text('No Record Found'), findsOneWidget);
  });

  testWidgets('renders HomeLoaded State when have recipes data', (WidgetTester tester) async {
    const homePage = HomePage();
    final homeBloc = HomeBlocMock();
    List<Recipe> tRecipes = anyRecipes1;
    try {
      // arrange
      mocktail.when(() => homeBloc.state).thenReturn(HomeLoadedState(recipes: tRecipes));
      //act
      await tester.pumpWidget(makeTestableWidget(
        child: homePage,
        bloc: homeBloc,
      ));
    } catch (e) {
      safePrint(e);
    }
    // assert
    expect(find.byKey(const Key('home_menu')), findsOneWidget);
    expectLater(find.byType(HomeMenu), findsOneWidget);
  });

  testWidgets('renders ShowSnackBar State when No Internet Connection', (WidgetTester tester) async {
    const homePage = HomePage();
    final homeBloc = HomeBlocMock();
    try {
      // arrange
      mocktail.when(() => homeBloc.state).thenReturn(HomeInitialState());
      whenListen(homeBloc,   Stream.fromIterable([ShowSnackBarState(message: 'No Internet Connection')]));
      //act
      await tester.pumpWidget(makeTestableWidget(
        child: homePage,
        bloc: homeBloc,
      ));
    } catch (e) {
      safePrint(e);
    }
    // assert
    await tester.pump();
    expect(find.byType(ScaffoldMessenger), findsOneWidget);
    expect(find.byKey(const Key('my_show_snackBar_view')), findsOneWidget);
    expect(find.text('No Internet Connection'), findsOneWidget);
  });

  /*
    final scaffoldFinder = find.byType(ScaffoldMessenger);
    expectLater(scaffoldFinder, findsOneWidget);
    var scaffoldMessenger =
        scaffoldFinder.evaluate().single.widget as ScaffoldMessenger;
    expectLater(find.byWidget(scaffoldMessenger), findsOneWidget);

    expectLater(scaffoldMessenger, findsOneWidget);
    var snackBar = scaffoldMessenger.child as SnackBar;
    var text = snackBar.content as Text;
    expectLater(text.data, equals('No Internet Connection'));
    */
}
