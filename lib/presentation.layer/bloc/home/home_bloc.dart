import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:food_app_flutter/domain.layer/repositories/api.repository.dart';
import '../../../domain.layer/entities/recipe.dart';
import '../../ui.util/error.message.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiRepository repository;

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
        emit(ShowSnackBar(message: errorMessage.text));
        emit(HomeError(message: 'No Record Found'));
      }, (recipes) {
        if (recipes.isNotEmpty) {
          emit(ShowSnackBar(message: 'You fetch Record Successfully'));
          emit(HomeLoaded(recipes: recipes));
        } else {
          emit(ShowSnackBar(message: 'No Record Found'));
          emit(HomeError(message: 'No Record Found'));
        }
      });
    }
  }
}
