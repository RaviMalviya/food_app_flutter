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

  HomeBloc({required this.repository}) : super(HomeInitialState()) {
    on<GetRecipeEvent>(_fetchRecipeList);
  }

  FutureOr<void> _fetchRecipeList(
      HomeEvent event, Emitter<HomeState> emit) async {
    if (event is GetRecipeEvent) {
      emit(HomeLoadingState());
      var result = await repository.getRecipe();

      result.fold((failure) {
        var errorMessage = ErrorMessageExt.enumName(failure: failure);
        emit(ShowSnackBarState(message: errorMessage.text));
        emit(HomeErrorState(message: 'No Record Found'));
      }, (recipes) {
        if (recipes.isNotEmpty) {
          emit(ShowSnackBarState(message: 'You fetch Record Successfully'));
          emit(HomeLoadedState(recipes: recipes));
        } else {
          emit(ShowSnackBarState(message: 'No Record Found'));
          emit(HomeErrorState(message: 'No Record Found'));
        }
      });
    }
  }
}
