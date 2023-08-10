
class NoInternetException implements Exception {}

class ServerException implements Exception {
  final int statusCode;
  ServerException(this.statusCode);
}

class InvalidInputException implements Exception {}

class InvalidOutputException implements Exception {}