import '../../../domain.layer/entities/recipe.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Recipe> recipes;

  HomeLoaded(this.recipes);
}

class ShowSnackBarError extends HomeState {
  final String message;

  ShowSnackBarError(this.message);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
