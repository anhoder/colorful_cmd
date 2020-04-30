part of exception;

class MustNotNullException implements Exception {
  final String message;

  MustNotNullException([this.message]);

  @override
  String toString() => ColorText().red('The variable cannot be set to null: $message').toString();
}