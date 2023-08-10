import 'package:flutter/material.dart';
import 'package:food_app_flutter/routes/go_route_config.dart';
import 'dart:async';
import 'core/util/helpers.dart';
import 'injection_container.dart' as di;

void main() async {
  await runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();

      await di.init();
      runApp(const MyApp());
    },
    (error, st) => safePrint(error),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: AppGoRouter.router,
    );
  }
}
