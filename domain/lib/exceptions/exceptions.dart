/// Base class for all domain-specific exceptions.
abstract class DomainException implements Exception {
  final String message;
  final Object? originalException;
  DomainException(this.message, [this.originalException]);
}

/// Thrown when a network error occurs (e.g., no internet connection).
class NetworkException extends DomainException {
  NetworkException(super.message, [super.originalException]);
}

/// Thrown when data parsing fails (e.g., malformed JSON).
class DataParsingException extends DomainException {
  DataParsingException(super.message, [super.originalException]);
}

/// Thrown when a specific resource is not found (e.g., 404 error).
class DataNotFoundException extends DomainException {
  DataNotFoundException(super.message, [super.originalException]);
}

/// Thrown when the server has an internal error (e.g., 5xx status code).
class ServerException extends DomainException {
  ServerException(super.message, [super.originalException]);
}

/// Thrown when a request is unauthorized (e.g., 401 or 403 status code).
class UnauthorizedException extends DomainException {
  UnauthorizedException(super.message, [super.originalException]);
}

class OfflineException extends DomainException {
  OfflineException(super.message, [super.originalException]);
}