
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // Override this method from the Equatable and give it list of the props
  @override
  List<Object> get props => [];
}

// General Failure
class NoInternetFailure extends Failure {
  NoInternetFailure() : super();
}

class ServerFailure extends Failure {
  ServerFailure() : super();
}

class InvalidInputFailure extends Failure {
  InvalidInputFailure() : super();
}

class InvalidOutputFailure extends Failure {
  InvalidOutputFailure() : super();
}

class UnknownFailure extends Failure {
  UnknownFailure() : super();
}