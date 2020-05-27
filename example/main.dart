import 'package:colorful_cmd/command.dart';
import 'package:colorful_cmd/utils.dart';
import 'root_command.dart';
import 'test_group.dart';

void main(List<String> args) {
  var kernel = ConsoleKernel();
  kernel.addCommands([RootCommand()]).addGroup(TestGroup()).run(args);

  var colorText = ColorText();
  colorText
    ..gold('\n\n\ngold\n')
    ..green('green\n')
    ..blue('blue\n')
    ..cyan('cyan\n')
    ..darkBlue('darkBlue\n')
    ..darkRed('darkRed\n')
    ..gray('gray\n')
    ..lightCyan('lightCyan\n')
    ..lightGray('lightGray\n')
    ..lightMagenta('lightMagenta\n')
    ..lime('lime\n')
    ..magenta('magenta\n')
    ..red('red\n')
    ..white('white\n')
    ..black('black\n')
    ..yellow('yellow\n')
    ..print();
}
