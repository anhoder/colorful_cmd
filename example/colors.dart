import 'package:console/console.dart';
import 'package:command/command.dart';

void main(List<String> args) {
  var kernel = ConsoleKernel();
  kernel.run(args);

  var pen = TextPen()
    ..gold()..text('gold\n')
    ..green()..text('green\n')
    ..blue()..text('blue\n')
    ..cyan()..text('cyan\n')
    ..darkBlue()..text('darkBlue\n')
    ..darkRed()..text('darkRed\n')
    ..gray()..text('gray\n')
    ..lightCyan()..text('lightCyan\n')
    ..lightGray()..text('lightGray\n')
    ..lightMagenta()..text('lightMagenta\n')
    ..lime()..text('lime\n')
    ..magenta()..text('magenta\n')
    ..red()..text('red\n')
    ..white()..text('white\n')
    ..black()..text('black\n')
    ..yellow()..text('yellow\n')
    ..print();
}
