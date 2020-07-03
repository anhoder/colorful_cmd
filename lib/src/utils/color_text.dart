part of utils;

class ColorText {
  Color _currentTextColor;
  Color _currentBgColor;
  bool isXterm = false;
  final StringBuffer _buffer = StringBuffer();

  ColorText() {
    var env = Platform.environment;
    if (!env.containsKey('TERM')) return;
    if (!env['TERM'].contains('256')) return;
    isXterm = true;
  }

  ColorText setTextColor(int id, {bool bright = false}) {
    Color color;
    if (isXterm) {
      var c = id.clamp(0, 256);
      color = Color(c, xterm: true);
      sgr(38, [5, c]);
    } else {
      color = Color(id, bright: true);
      if (bright) {
        sgr(30 + id, [1]);
      } else {
        sgr(30 + id);
      }
    }
    _currentTextColor = color;
    return this;
  }

  Color getTextColor() => _currentTextColor;

  ColorText setBackgroundColor(int id,
      {bool bright = false}) {
    Color color;
    if (isXterm) {
      var c = id.clamp(0, 256);
      color = Color(c, xterm: true);
      sgr(48, [5, c]);
    } else {
      color = Color(id, bright: true);
      if (bright) {
        sgr(40 + id, [1]);
      } else {
        sgr(40 + id);
      }
    }
    _currentBgColor = color;
    return this;
  }

  Color getBackgroundColor() => _currentBgColor;

  void sgr(int id, [List<int> params]) {
    String stuff;
    if (params != null) {
      stuff = "${id};${params.join(";")}";
    } else {
      stuff = id.toString();
    }
    ansi('${stuff}m');
  }

  void ansi(String after) => _buffer.write('${Console.ANSI_ESCAPE}${after}');

  ColorText reset() {
    sgr(0);
    _currentTextColor = null;
    _currentBgColor = null;
    return this;
  }

  @override
  String toString() => _buffer.toString();

  ColorText setColor(Color color) {
    setTextColor(color.id, bright: color.bright);
    return this;
  }

  ColorText text(String str) {
    _buffer.write(str);
    return this;
  }

  ColorText normal() => reset();

  ColorText paintingText(String str, Color color) {
    setColor(color);
    text(str);
    reset();
    return this;
  }

  ColorText black(str) => paintingText(str, Colors.BLACK);

  ColorText blue(str) => paintingText(str, Colors.BLUE);

  ColorText cyan(str) => paintingText(str, Colors.CYAN);

  ColorText darkBlue(str) => paintingText(str, Colors.DARK_BLUE);

  ColorText darkRed(str) => paintingText(str, Colors.DARK_RED);

  ColorText gold(str) => paintingText(str, Colors.GOLD);

  ColorText gray(str) => paintingText(str, Colors.GRAY);

  ColorText green(str) => paintingText(str, Colors.GREEN);

  ColorText lightCyan(str) => paintingText(str, Colors.LIGHT_CYAN);

  ColorText lightGray(str) => paintingText(str, Colors.LIGHT_GRAY);

  ColorText lightMagenta(str) => paintingText(str, Colors.LIGHT_MAGENTA);

  ColorText lime(str) => paintingText(str, Colors.LIME);

  ColorText magenta(str) => paintingText(str, Colors.MAGENTA);

  ColorText red(str) => paintingText(str, Colors.RED);

  ColorText white(str) => paintingText(str, Colors.WHITE);

  ColorText yellow(str) => paintingText(str, Colors.YELLOW);

  void print() => stdout.write(_buffer);
}
