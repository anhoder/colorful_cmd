import 'package:command/command.dart';
import 'package:command/logger.dart';

class Foo extends Cmd {

  @override
  String name = 'foo';
  @override
  String description = 'this is foo';

  @override
  List<ILogHandler> get logHandlers => [FileLogHandler()];
  
  @override
  void run() {
    print(description);
  }

}

class Bar extends Cmd {

  @override
  String name = 'bar';
  @override
  String description = 'this is bar';

  @override
  List<ILogHandler> get logHandlers => [FileLogHandler()];
  
  @override
  void run() {
    print(description);
  }
}

class TestGroup extends IGroup {
  @override
  String get description => 'test group description';

  @override
  String get name => 'test';

  @override
  List<Cmd> get commands => [
    Foo(),
    Bar()
  ];

  @override
  List<IGroup> get groups => null;

}

void main(List<String> args) {
  var kernel = ConsoleKernel();
  kernel.addCommand(Foo());
  kernel.addGroup(TestGroup());
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
