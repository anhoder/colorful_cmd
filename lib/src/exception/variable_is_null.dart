part of exception;

class VariableIsNull implements Exception {
  final String message;

  const VariableIsNull([this.message]);

  @override
  String toString() => 'Variable cannot be set to null: ${message ?? ''}';
}