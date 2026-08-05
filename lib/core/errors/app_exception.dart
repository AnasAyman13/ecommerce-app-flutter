class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  const NetworkException([super.message = 'No internet connection']);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([super.message = 'Session expired'])
    : super(statusCode: 401);
}
