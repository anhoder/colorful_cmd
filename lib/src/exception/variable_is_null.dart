part of exception;

class VariableIsNullException implements Exception {
  final String message;

  const VariableIsNullException([this.message]);

  @override
  String toString() => 'Variable cannot be set to null: ${message ?? ''}';
}