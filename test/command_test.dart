import 'package:command/command.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    ConsoleKernel awesome;

    setUp(() {
      awesome = ConsoleKernel();
    });

    test('First Test', () {
      expect(awesome, isTrue);
    });
  });
}
