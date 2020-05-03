
import 'package:colorful_cmd/command.dart';
import 'package:colorful_cmd/logger.dart';

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