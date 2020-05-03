part of exception;

class LogLevelNotFoundException implements Exception {
  final String message;

  const LogLevelNotFoundException([this.message]);

  @override
  String toString() => 'Log level not found: ${message ?? ''}';
}