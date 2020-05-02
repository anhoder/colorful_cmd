part of command;

abstract class Cmd<T> extends Command<T> {

  @override
  String name;
  @override
  String description;
  Logger logger;

  List<ILogHandler> get logHandlers;
  
  Cmd() {
    logger = Logger(logHandlers: logHandlers);
  }

  String wrap(String text, {int hangingIndent}) => wrapText(text,
    length: argParser.usageLineLength, hangingIndent: hangingIndent);
}