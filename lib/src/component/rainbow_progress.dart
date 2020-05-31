part of component;

const List<Color> RainbowColors = [
  Color.RED,
  Color.DARK_RED,
  Color.GOLD,
  Color.YELLOW,
  Color.LIME,
  Color.GREEN,
  Color.LIGHT_CYAN,
  Color.CYAN,
  Color.BLUE,
  Color.DARK_BLUE,
  Color.LIGHT_MAGENTA,
  Color.MAGENTA,
  Color.LIGHT_MAGENTA,
  Color.DARK_BLUE,
  Color.BLUE,
  Color.CYAN,
  Color.LIGHT_CYAN,
  Color.GREEN,
  Color.LIME,
  Color.YELLOW,
  Color.GOLD,
  Color.DARK_RED,
];

class RainbowProgress {
  final int complete;
  final bool showPercent;
  final String completeChar;
  final String forwardChar;
  final String unfinishChar;
  final String leftDelimiter;
  final String rightDelimiter;
  final bool rainbow;
  final int startColumn;
  final int column;
  final int row;

  int width;
  int current = 0;
  int _startColorIndex;

  /// Creates a Progress Bar.
  ///
  /// [complete] is the number that is considered 100%.
  RainbowProgress(
      {this.complete = 100,
      this.width,
      this.column,
      this.row,
      this.startColumn = 1,
      this.completeChar = '=',
      this.forwardChar = '>',
      this.unfinishChar = ' ',
      this.leftDelimiter = '[',
      this.rightDelimiter = ']',
      this.rainbow = true,
      this.showPercent = true}) {
    width ??= Console.columns;
    _startColorIndex = Random().nextInt(RainbowColors.length - 1);
  }

  void update(int progress) {
    if (progress == current) {
      return;
    }

    current = progress;

    var ratio = progress / complete;
    var percent = (ratio * 100).toInt();

    var digits = percent.toString().length;

    var w = showPercent ? width - digits - 4 : width - 2;

    var count = (ratio * w).toInt();
    var before = showPercent ? '${percent}% ${leftDelimiter}' : leftDelimiter;
    var after = rightDelimiter;

    var out = StringBuffer(before);

    var colorIndex = _startColorIndex;

    for (var x = 1; x < count; x++, colorIndex++) {
      var content = ColorText();
      if (rainbow)
        content.setColor(RainbowColors[colorIndex % RainbowColors.length]);

      content.text(completeChar).normal();
      out.write(content);
    }

    var forward = ColorText();
    if (rainbow)
      forward.setColor(RainbowColors[colorIndex % RainbowColors.length]);
    forward.text(forwardChar).normal();
    out.write(forward.toString());
    colorIndex++;

    for (var x = count + 1; x < w; x++) {
      out.write(unfinishChar);
    }

    if (current != 1 && current != complete) out.write(unfinishChar);

    out.write(after);

    if (out.length - 1 == Console.columns) {
      var it = out.toString();

      out.clear();
      out.write(it.substring(0, it.length - 2) + rightDelimiter);
    }

    if (column == null && row == null) {
      Console.write('\r${out.toString()}');
    } else {
      Console.moveCursor(column: column ?? 0, row: row ?? 0);
      Console.write('\r${out.toString()}');
    }
  }
}
