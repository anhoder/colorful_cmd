part of exception;

class FileNotExistsException implements Exception {
  final String message;

  const FileNotExistsException([this.message]);

  @override
  String toString() => 'File or dir not exists: ${message ?? ''}';
}
