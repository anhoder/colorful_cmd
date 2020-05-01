part of command;

abstract class Command extends cr.Command {

  List<ILogHandler> get loggers;

  IInput _input;

  IOutput _output;
}