part of 'home_bloc.dart';

abstract class HomeState extends Equatable {}

class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoaded extends HomeState {
  final List<Recipe> recipes;
  HomeLoaded({required this.recipes});

  @override
  List<Object?> get props => [recipes];
}

class ShowSnackBar extends HomeState {
  final String message;
  ShowSnackBar({required this.message});

  @override
  List<Object?> get props => [message];
}

class HomeError extends HomeState {
  final String message;
  HomeError({required this.message});

  @override
  List<Object?> get props => [message];
}
