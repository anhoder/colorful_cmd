part of command;

class ConsoleKernel<T> extends cr.CommandRunner{
  bool get showTitle => true;
  Color get titleColor => randomColor();

  ConsoleKernel([name = 'dart-cmd', description = 'A library for building a beautiful command line application in dart.']): 
    super(name, description);


  @override
  String get usage {
    var usagePrefix = 'Usage: \n';
    var pen = ColorText()
      .lightCyan(wrap('$description\n\n'))
      .gold(wrap(usagePrefix))
      .green('  ${wrap(invocation, hangingIndent: usagePrefix.length)}\n\n')
      .gold('Global options: \n')
      .green('  ${argParser.usage}\n\n')
      .text('${getCommandUsage(commands, lineLength: argParser.usageLineLength)}\n');

    if (usageFooter != null) {
      pen.text('\n${wrap(usageFooter)}\n\n');
    }

    return pen.toString();
  }


  @override
  Future run(Iterable<String> args) {
    displayTitle();
    return super.run(args);
  }


  /// display title when console start run.
  void displayTitle() {
    if (showTitle) {
      TextPen().setColor(titleColor)
        .text('${formatChars(executableName)}\n')
        .normal()
        .print();
    }
  }


  String wrap(String text, {int hangingIndent}) => wrapText(text,
      length: argParser.usageLineLength, hangingIndent: hangingIndent);

  
  String getCommandUsage(Map<String, cr.Command> commands,
      {bool isSubcommand = false, int lineLength}) {
    // Don't include aliases.
    var names =
        commands.keys.where((name) => !commands[name].aliases.contains(name));

    // Filter out hidden ones, unless they are all hidden.
    var visible = names.where((name) => !commands[name].hidden);
    if (visible.isNotEmpty) names = visible;

    // Show the commands alphabetically.
    names = names.toList()..sort();
    var length = names.map((name) {
      if (name == null) throw MustNotNullException('Command => `name`');
      if (commands[name].description == null) throw MustNotNullException('Command(`$name`) => `description`');
      return name.length;
    }).reduce(max);

    var buffer = StringBuffer(ColorText().yellow('Available ${isSubcommand ? "sub" : ""}commands:'));
    var columnStart = length + 5;
    for (var name in names) {
      var lines = wrapTextAsLines(commands[name].summary,
          start: columnStart, length: lineLength);
      buffer.writeln();
      buffer.write(ColorText().green('  ${padRight(name, length)}   ${lines.first}'));

      for (var line in lines.skip(1)) {
        buffer.writeln();
        buffer.write(' ' * columnStart);
        buffer.write(line);
      }
    }

    return buffer.toString();
  }
}