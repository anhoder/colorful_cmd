
import 'package:command/command.dart';
import 'package:command/logger.dart';

class BarCommand extends ICmd {

  @override
  String name = 'bar';
  @override
  String description = 'this is bar';

  @override
  List<ILogHandler> get logHandlers => [FileLogHandler()];
  
  @override
  void run() {
    info('$name: $description');
  }

  @override
  List<Flag> get flags => null;

  @override
  List<Option> get options => null;
}