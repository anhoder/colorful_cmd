part of command;

abstract class Command extends cr.Command {

  ILogHandler get logger;

  IInput _input;

  IOutput _output;
}