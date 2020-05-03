import 'package:colorful_cmd/command.dart';
import 'package:colorful_cmd/logger.dart';

class FooCommand extends ICmd {
  @override
  String name = 'foo';
  @override
  String description = 'this is foo';

  @override
  List<ILogHandler> get logHandlers => [StdLogHandler(), FileLogHandler()];
  
  @override
  void run() {
    info('input debug: ' + getInput('d').toString());
    debug('input test: ' + getInput('t').toString());
    warning('input option: ' + getInput('o').toString());
    error(getInputs().toString());
  }

  @override
  List<Flag> get flags => [
    Flag('debug', abbr: 'd', defaultsTo: false, negatable: true, help: 'run in debug mode'),
    Flag('flag', abbr: 'f', defaultsTo: false, negatable: true, help: 'test flag')
  ];

  @override
  List<Option> get options => [
    Option('option', abbr: 'o', help: 'test option')
  ];

}