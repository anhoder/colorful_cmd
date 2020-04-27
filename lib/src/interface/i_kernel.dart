part of command;

abstract class Kernel {
  List<ICommand> commands;

  void run(IInput input, IOutput output);
}