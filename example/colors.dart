import 'package:command/command.dart';
import 'package:command/logger.dart';

/// Foo Command
class Foo extends ICmd {

  @override
  String name = 'foo';
  @override
  String description = 'this is foo';

  @override
  List<ILogHandler> get logHandlers => [StdLogHandler(), FileLogHandler()];
  
  @override
  void run() {
    info(argResults.arguments.toList().toString());
  }

  @override
  List<Flag> get flags => [
    Flag('debug', abbr: 'd', defaultsTo: false, negatable: true, help: 'run in debug mode'),
    Flag('t', abbr: 't', defaultsTo: false, negatable: true, help: 'run in debug mode')
  ];

  @override
  List<Option> get options => null;

}


/// Bar Command
class Bar extends ICmd {

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

  @override
  List<Flag> get flags => null;

  @override
  List<Option> get options => null;
}


/// Test Group
class TestGroup extends IGroup {

  @override
  String get name => 'test';

  @override
  List<ICmd> get commands => [
    Foo(),
    Bar()
  ];

  @override
  List<IGroup> get groups => null;

}


/// Kernel
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
