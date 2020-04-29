part of command;

class ConsoleKernel extends cr.CommandRunner{
  bool showTitle = true;

  ConsoleKernel([name = 'Command', description = 'The Kernel of dart-command.']): 
    super(name, TextPen().yellow().text(description).yellow().toString());

  @override
  Future run(Iterable<String> args) {
    displayTitle();
    return super.run(args);
  }

  void displayTitle() {
    if (showTitle) {
      TextPen().blue().text(formatChars(executableName))
        .text('\n')
        .print();
    }
  }
}