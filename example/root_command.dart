
import 'package:colorful_cmd/command.dart';
import 'package:colorful_cmd/logger.dart';

class RootCommand extends ICmd {

  @override
  String name = 'root';

  @override
  String description = 'root command, without group';

  @override
  List<Flag> get flags => null;

  @override
  List<ILogHandler> get logHandlers => null;

  @override
  List<Option> get options => null;
  
  @override
  void run() {
    warning(description);
  }
}