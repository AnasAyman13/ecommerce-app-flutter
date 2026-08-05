import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

/// Network or server-related failures
class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure({required String message, this.statusCode})
    : super(message);

  @override
  List<Object> get props => [message, statusCode ?? 0];
}

/// No internet connection
class NetworkFailure extends Failure {
  const NetworkFailure({String message = 'No internet connection'})
    : super(message);
}

/// Authentication failures (401, 403)
class AuthFailure extends Failure {
  const AuthFailure({String message = 'Authentication failed'})
    : super(message);
}

/// Local cache / storage failures
class CacheFailure extends Failure {
  const CacheFailure({String message = 'Cache error'}) : super(message);
}

/// Validation failures
class ValidationFailure extends Failure {
  const ValidationFailure({required String message}) : super(message);
}

/// Unknown / unexpected failures
class UnknownFailure extends Failure {
  const UnknownFailure({String message = 'An unexpected error occurred'})
    : super(message);
}
