part of exception;

class OptionOrFlagRepeatException implements Exception {
  final String message;

  OptionOrFlagRepeatException(this.message);

  @override
  String toString() => 'Option or flag repeat: ${message ?? ''}';
}