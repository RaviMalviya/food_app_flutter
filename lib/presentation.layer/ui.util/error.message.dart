

import '../../core/error/failures.dart';

enum ErrorMessage {
  unexpected,
  noInternet,
  server,
  invalidInput,
}
extension ErrorMessageExt on ErrorMessage {
  String get text {
    switch (this) {
      case ErrorMessage.server:
        return 'Server Failure';
      case ErrorMessage.invalidInput:
        return 'Invalid Input Data Failure';
      case ErrorMessage.noInternet:
        return 'No Internet Failure';
      case ErrorMessage.unexpected:
        return 'Unexpected Failure';
    }
  }
  static ErrorMessage enumName({required Failure failure}) {
    switch (failure.runtimeType) {
      case NoInternetFailure:
        return ErrorMessage.noInternet;
      case ServerFailure:
        return ErrorMessage.server;
      case InvalidInputFailure:
        return ErrorMessage.invalidInput;
    }
    return ErrorMessage.unexpected;
  }
}