part of command;

class Flag {
  final String name;
  final String abbr;
  final String help;
  final bool defaultsTo;
  final bool negatable; // --debug --no-debug
  final void Function(bool) callback;
  final bool hide;

  Flag(this.name, {
    this.abbr,
    this.help,
    this.defaultsTo = false,
    this.negatable = true,
    this.callback,
    this.hide = false}
  );
}