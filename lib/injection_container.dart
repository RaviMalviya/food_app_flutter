import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'data.layer/data.sources/remote/api.provider_fake.dart';
import 'package:food_app_flutter/data.layer/data.sources/api.provider.dart';
import 'package:food_app_flutter/data.layer/repositories/remote/api.repository_impl.dart';
import 'package:food_app_flutter/features.layer/bloc/home/home_bloc.dart';
import 'package:get_it/get_it.dart';

import 'core/network/network_info.dart';
import 'data.layer/data.sources/remote/api.provider_impl.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {

  //! Features - Number Trivia

  // Bloc
  sl.registerFactory(() => HomeBloc(repository: sl()));
  // Use Case
  // sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  // Repository
  sl.registerLazySingleton<ApiRepositoryImpl>(() => ApiRepositoryImpl(networkInfo: sl(), provider: sl())); // ApiProviderImpl()
  // Data Sources
  sl.registerLazySingleton<ApiProvider>(() => ApiProviderFake());
  // sl.registerLazySingleton<ApiProvider>(() => ApiProviderImpl(client: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(internetAddressInfo: sl(), connectivity: sl(), streamController: sl()));
  sl.registerLazySingleton<InternetAddressInfo>(() => InternetAddressInfoImpl());

  //! External
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<StreamController>(() => StreamController.broadcast());
  sl.registerLazySingleton<http.Client>(() => http.Client());
  // final sharedPreferences = await SharedPreferences.getInstance();
  // sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}