part of command;

abstract class ICmd<T> extends Command<T> {

  @override
  String name;
  @override
  String description;
  Logger logger;

  List<Flag> get flags;
  List<Option> get options;

  final Map<String, String> _shortNameMap;
  final List<String> _optionNames;

  // TODO: extend group's log handler
  List<ILogHandler> get logHandlers;
  
  ICmd(): _shortNameMap = {}, _optionNames = [] {
    try {
      logger = Logger(logHandlers: logHandlers);

      /// validate name and description
      if (name == null || name == '') throw VariableIsNullException('(${runtimeType})\'s name');
      description ??= '';


      _addFlags();
      
      _addOptions();
      
    } catch(e, s) {
      logger.error(e).trace(s);
      exit(0);
    }
  }

  /// add flags
  void _addFlags() {
    if (flags != null && flags.isNotEmpty) {
      flags.forEach((flag) {
        if (_optionNames.contains(flag.name)) throw OptionOrFlagRepeatException(flag.name);
        _optionNames.add(flag.name);
        if (flag.abbr != null) {
          if (_optionNames.contains(flag.abbr) && flag.abbr != flag.name) throw OptionOrFlagRepeatException(flag.abbr);
          _optionNames.add(flag.abbr);
          _shortNameMap[flag.abbr] = flag.name;
        }
        argParser.addFlag(
          flag.name, 
          abbr: flag.abbr, 
          help: flag.help,
          defaultsTo: flag.defaultsTo,
          negatable: flag.negatable,
          callback: flag.callback,
          hide: flag.hide
        );
      });
    }
  }

  /// add options
  void _addOptions() {
    if (options != null && options.isNotEmpty) {
      options.forEach((option) {
        if (_optionNames.contains(option.name)) throw OptionOrFlagRepeatException(option.name);
        _optionNames.add(option.name);
        if (option.abbr != null) {
          if (_optionNames.contains(option.abbr) && option.abbr != option.name) throw OptionOrFlagRepeatException(option.abbr);
          _optionNames.add(option.abbr);
          _shortNameMap[option.abbr] = option.name;
        }
        if (option.type == OptionType.single) {
          argParser.addOption(
            option.name,
            abbr: option.abbr,
            help: option.help,
            valueHelp: option.valueHelp,
            defaultsTo: option.defaultsTo,
            allowed: option.allowed,
            allowedHelp: option.allowedHelp,
            callback: option.callback,
            hide: option.hide
          );
        } else {
          argParser.addMultiOption(
            option.name,
            abbr: option.abbr,
            help: option.help,
            valueHelp: option.valueHelp,
            defaultsTo: option.mutilDefaultsTo,
            allowed: option.allowed,
            allowedHelp: option.allowedHelp,
            callback: option.mutilCallback,
            hide: option.hide
          );
        }
      });
    }
  }

  /// get option or flag by name
  dynamic getInput(String name) {
    if (argResults.options.contains(name)) {
      return argResults[name];
    } else if (_shortNameMap.containsKey(name) && argResults.options.contains(_shortNameMap[name])) {
      return argResults[_shortNameMap[name]];
    }
    return null;
  }

  /// get all option and flags
  Map<String, dynamic> getInputs() {
    var inputs = <String, dynamic>{};
    _optionNames.forEach((name) => inputs[name] = getInput(name));
    return inputs;
  }

  /// print info
  void info(Object text, [Color color = Color.CYAN]) => printInfo(text, color);

  void debug(Object text) => printDebug(text);

  void warning(Object text) => printWarning(text);

  void trace(Object text) => printTrace(text);

  void error(Object text) => printError(text);

  @override
  ConsoleKernel<T> get runner => super.runner as ConsoleKernel;


  String _wrap(String text, {int hangingIndent}) => wrapText(text,
    length: argParser.usageLineLength, hangingIndent: hangingIndent);


  String _getTitle() {
    if (runner.showTitle) {
      return TextPen().setColor(runner.titleColor)
        .text('${formatChars(runner.executableName)}\n')
        .normal()
        .toString();
    }
    return '';
  }


  @override
  String get usage => ColorText().text(_getTitle()).cyan('$description\n\n').text(_usageWithoutDescription).toString();

  /// get usage
  String get _usageWithoutDescription {
    var length = argParser.usageLineLength;
    var usagePrefix = 'Usage: \n';
    var argUsage = '';
    argParser.usage.split('\n').forEach((line) {
      if (argUsage == '') {
        argUsage = '  $line\n';
      } else {
        argUsage = '$argUsage  $line\n';
      }
    });
    argUsage += '\n';

    var pen = ColorText()
      .gold(usagePrefix)
      .white('  ${_wrap(invocation, hangingIndent: usagePrefix.length)}\n\n')
      .gold('Options: \n')
      .green(argUsage);

    if (subcommands.isNotEmpty) {
      pen.text(_getCommandUsage(
        subcommands,
        isSubcommand: true,
        lineLength: length,
      ) + '\n');
    }

    if (usageFooter != null) {
      pen.cyan(_wrap(usageFooter) + '\n\n');
    }

    return pen.toString();
  }

  /// get commands usage.
  String _getCommandUsage(Map<String, Command> commands,
      {bool isSubcommand = false, int lineLength}) {
    // Don't include aliases.
    var names =
        commands.keys.where((name) => !commands[name].aliases.contains(name));

    // Filter out hidden ones, unless they are all hidden.
    var visible = names.where((name) => !commands[name].hidden);
    if (visible.isNotEmpty) names = visible;

    // Show the commands alphabetically.
    names = names.toList()..sort();

    var groupCmdMaps = <String, String>{};
    var cmdsNotInGroup = <String>[];
    names.forEach((name) {
      if (name == null) throw VariableIsNullException('${commands[name].runtimeType}\'s name');
      if (commands[name].description == null) throw VariableIsNullException('${commands[name].runtimeType}\'s description');
      var index = name.indexOf(':');
      if (index >= 0) {
        groupCmdMaps[name] = name.substring(0, index);
      } else {
        cmdsNotInGroup.add(name);
      }
    });

    var length = names.map((name) {
      return name.length;
    }).reduce(max);

    var buffer = StringBuffer(ColorText().yellow('Available ${isSubcommand ? "sub" : ""}commands:'));
    var columnStart = length + 5;

    /// display commands that not in groups
    for (var name in cmdsNotInGroup) {
      var lines = wrapTextAsLines(commands[name].summary,
          start: columnStart, length: lineLength);
      buffer.writeln();
      
      buffer.write(ColorText().green('  ${padRight(name, length)}   ').white(lines.first));

      for (var line in lines.skip(1)) {
        buffer.writeln();
        buffer.write(' ' * columnStart);
        buffer.write(line);
      }
    }


    /// display group commands
    var lastGroup = '';
    for (var name in names) {
      if (!groupCmdMaps.containsKey(name)) {
        continue;
      }
      var lines = wrapTextAsLines(commands[name].summary,
          start: columnStart, length: lineLength);
      
      buffer.writeln();
      if (lastGroup != groupCmdMaps[name]) {
        buffer.writeln(ColorText().yellow(' ${groupCmdMaps[name]}'));
        lastGroup = groupCmdMaps[name];
      }
      buffer.write(ColorText().green('  ${padRight(name, length)}   ').white(lines.first));

      for (var line in lines.skip(1)) {
        buffer.writeln();
        buffer.write(' ' * columnStart);
        buffer.write(line);
      }
    }

    return buffer.toString();
  }
}