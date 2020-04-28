part of command;

class ConsoleKernel extends cr.CommandRunner{
  ConsoleKernel([name = 'Console Kernel', description = 'The Kernel of dart-command.']): super(name, description);

  @override
  Future run(Iterable<String> args) {
    displayConsoleInfo();
    return super.run(args);
  }

  void displayConsoleInfo() {
    TextPen().green().text(format_chars(executableName))
      .text('\n')
      .yellow().text(description)
      .print();
  }
}