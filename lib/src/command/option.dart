part of command;

class Option {
  final String name;
  final String abbr;
  final String help;
  final String valueHelp;
  final Iterable<String> allowed;
  final Map<String, String> allowedHelp;
  final String defaultsTo;
  final Function callback;
  final bool splitCommas;
  final bool hide;

  final Iterable<String> mutilDefaultsTo;
  final void Function(List<String>) mutilCallback;

  final OptionType type;

  Option(this.name, {
    this.abbr,
    this.help,
    this.valueHelp,
    this.allowed,
    this.allowedHelp,
    this.defaultsTo,
    this.callback,
    this.hide = false
  }): mutilDefaultsTo = null, mutilCallback = null, splitCommas = false, type = OptionType.single;

  Option.mutil(this.name, {
    this.abbr,
    this.help,
    this.valueHelp,
    this.allowed,
    this.allowedHelp,
    this.mutilDefaultsTo,
    this.mutilCallback,
    this.hide = false
  }): defaultsTo = null, callback = null, splitCommas = true, type = OptionType.multiple;
}