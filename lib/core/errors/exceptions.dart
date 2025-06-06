class CacheException implements Exception {}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
}
