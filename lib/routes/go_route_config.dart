import 'package:flutter/material.dart';
import 'package:food_app_flutter/routes/route_constant.dart';
import 'package:go_router/go_router.dart';
import 'package:food_app_flutter/injection_container.dart';
import '../presentation.layer/bloc/home/home_bloc.dart';
import '../presentation.layer/pages/home.dart';
import 'error_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppGoRouter {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: AppRoute.home.name,
        path: AppRoute.home.path,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: BlocProvider(
              create: (_) =>  sl<HomeBloc>()..add(GetRecipeEvent()),
              child: const HomePage(),
            ),
          );
        },
      ),
    ],
    errorPageBuilder: (context, state) {
      return const MaterialPage(child: ErrorPage());
    },
  );
}
