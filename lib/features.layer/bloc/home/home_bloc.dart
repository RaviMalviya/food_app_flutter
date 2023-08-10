import 'dart:async';
import 'package:food_app_flutter/features.layer/bloc/home/home_event.dart';
import 'package:food_app_flutter/features.layer/bloc/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_flutter/data.layer/repositories/remote/api.repository_impl.dart';
import 'package:food_app_flutter/features.layer/ui.util/error.message.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiRepositoryImpl repository;

  HomeBloc({required this.repository}) : super(HomeInitial()) {
    on<GetRecipeEvent>(_fetchRecipeList);
  }

  FutureOr<void> _fetchRecipeList(
      HomeEvent event, Emitter<HomeState> emit) async {
    if (event is GetRecipeEvent) {
      emit(HomeLoading());
      var result = await repository.getRecipe();

      result.fold((failure) {
        var errorMessage = ErrorMessageExt.enumName(failure: failure);
        emit(ShowSnackBarError(errorMessage.text));
        emit(HomeError('No Record Found'));
      }, (recipes) {
        if (recipes.isNotEmpty) {
          emit(ShowSnackBarError('You fetch Record Successfully'));
          emit(HomeLoaded(recipes));
        } else {
          emit(ShowSnackBarError('No Record Found'));
          emit(HomeError('No Record Found'));
        }
      });
    }
  }
}
