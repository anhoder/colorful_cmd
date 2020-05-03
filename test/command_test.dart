import 'package:colorful_cmd/command.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    ConsoleKernel kernel;

    setUp(() {
      kernel = ConsoleKernel();
    });

    test('First Test', () {
      expect(kernel, isTrue);
    });
  });
}
