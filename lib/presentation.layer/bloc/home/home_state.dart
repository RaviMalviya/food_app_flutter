part of 'home_bloc.dart';

abstract class HomeState extends Equatable {}

class HomeInitialState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoadedState extends HomeState {
  final List<Recipe> recipes;
  HomeLoadedState({required this.recipes});

  @override
  List<Object?> get props => [recipes];
}

class ShowSnackBarState extends HomeState {
  final String message;
  ShowSnackBarState({required this.message});

  @override
  List<Object?> get props => [message];
}

class HomeErrorState extends HomeState {
  final String message;
  HomeErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
