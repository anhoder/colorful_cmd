import 'package:command/command.dart';
import 'package:command/logger.dart';

class A extends Command {
  @override
  String get description => '123';

  @override
  ILogHandler get logger => DBLogHandler();

  @override
  String get name => '123';
  
}

void main(List<String> args) {
  var kernel = ConsoleKernel();
  var cmd = A();
  kernel.addCommand(cmd);
  kernel.run(args);

  // var colorText = ColorText();
  // colorText
  //   ..gold('\n\n\ngold\n')
  //   ..green('green\n')
  //   ..blue('blue\n')
  //   ..cyan('cyan\n')
  //   ..darkBlue('darkBlue\n')
  //   ..darkRed('darkRed\n')
  //   ..gray('gray\n')
  //   ..lightCyan('lightCyan\n')
  //   ..lightGray('lightGray\n')
  //   ..lightMagenta('lightMagenta\n')
  //   ..lime('lime\n')
  //   ..magenta('magenta\n')
  //   ..red('red\n')
  //   ..white('white\n')
  //   ..black('black\n')
  //   ..yellow('yellow\n')
  //   ..print();
}
