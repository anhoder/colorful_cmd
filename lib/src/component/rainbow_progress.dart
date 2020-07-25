part of component;

List<Color> RainbowColors = [
  Colors.RED,
  Colors.DARK_RED,
  Colors.GOLD,
  Colors.YELLOW,
  Colors.LIME,
  Colors.GREEN,
  Colors.LIGHT_CYAN,
  Colors.CYAN,
  Colors.BLUE,
  Colors.DARK_BLUE,
  Colors.LIGHT_MAGENTA,
  Colors.MAGENTA,
  Colors.LIGHT_MAGENTA,
  Colors.DARK_BLUE,
  Colors.BLUE,
  Colors.CYAN,
  Colors.LIGHT_CYAN,
  Colors.GREEN,
  Colors.LIME,
  Colors.YELLOW,
  Colors.GOLD,
  Colors.DARK_RED,
];


List<Color> getXtermRainbowColors() {
  var starts = [
    16,17,18,19,20,21,
    52,53,54,55,56,57,
    88,89,90,91,92,93,
    124,125,126,127,128,129,
    160,161,162,163,164,165,
    196,197,198,199,200,201,
  ];
  var startIndex = Random().nextInt(starts.length - 1);
  var start = starts[startIndex];
  return [
    Color(start, xterm: true),
    Color(start + 6, xterm: true),
    Color(start + 12, xterm: true),
    Color(start + 18, xterm: true),
    Color(start + 24, xterm: true),
    Color(start + 30, xterm: true),
    Color(start + 24, xterm: true),
    Color(start + 18, xterm: true),
    Color(start + 12, xterm: true),
    Color(start + 6, xterm: true),
  ];
}

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
  List<Color> _rainbowColors;

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
    Colors.init();
    if (Colors.isXterm) {
      _rainbowColors = getXtermRainbowColors();
    } else {
      _rainbowColors = RainbowColors;
    }
    _startColorIndex = Random().nextInt(_rainbowColors.length - 1);
  }

  void update(int progress) {
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
      if (rainbow) {
        content.setColor(_rainbowColors[colorIndex % _rainbowColors.length]);
      }

      content.text(completeChar).normal();
      out.write(content);
    }

    var forward = ColorText();
    if (rainbow) {
      forward.setColor(_rainbowColors[colorIndex % _rainbowColors.length]);
    }
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
