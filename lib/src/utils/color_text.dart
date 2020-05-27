part of utils;

class ColorText {
  Color _currentTextColor;
  Color _currentBgColor;
  final StringBuffer _buffer = StringBuffer();

  ColorText setTextColor(int id, {bool xterm = false, bool bright = false}) {
    Color color;
    if (xterm) {
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

  ColorText setBackgroundColor(int id, {bool xterm = false, bool bright = false}) {
    Color color;
    if (xterm) {
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
    setTextColor(color.id, xterm: color.xterm, bright: color.bright);
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

  ColorText black(str) => paintingText(str, Color.BLACK);

  ColorText blue(str) => paintingText(str, Color.BLUE);

  ColorText cyan(str) => paintingText(str, Color.CYAN);

  ColorText darkBlue(str) => paintingText(str, Color.DARK_BLUE);

  ColorText darkRed(str) => paintingText(str, Color.DARK_RED);

  ColorText gold(str) => paintingText(str, Color.GOLD);

  ColorText gray(str) => paintingText(str, Color.GRAY);

  ColorText green(str) => paintingText(str, Color.GREEN);

  ColorText lightCyan(str) => paintingText(str, Color.LIGHT_CYAN);

  ColorText lightGray(str) => paintingText(str, Color.LIGHT_GRAY);
  
  ColorText lightMagenta(str) => paintingText(str, Color.LIGHT_MAGENTA);
  
  ColorText lime(str) => paintingText(str, Color.LIME);
  
  ColorText magenta(str) => paintingText(str, Color.MAGENTA);
  
  ColorText red(str) => paintingText(str, Color.RED);

  ColorText white(str) => paintingText(str, Color.WHITE);
  
  ColorText yellow(str) => paintingText(str, Color.YELLOW);

  void print() => stdout.write(_buffer);
}
