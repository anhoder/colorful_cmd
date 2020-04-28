part of command;

abstract class IKernel {
  List<cr.Command> commands;

  void run(IInput input, IOutput output);
}