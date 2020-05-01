part of exception;

class MustNotNullException implements Exception {
  final String message;

  const MustNotNullException([this.message]);

  @override
  String toString() => 'Variable cannot be set to null: ${message ?? ''}';
}