part of utils;

class ColorText extends TextPen {
  Map<String, Function> _method_mapping;

  ColorText() : super() {
    _method_mapping = {
      'gold': super.gold,
      'green': super.green,
      'blue': super.blue,
      'cyan': super.cyan,
      'darkBlue': super.darkBlue,
      'darkRed': super.darkRed,
      'gray': super.gray,
      'lightCyan': super.lightCyan,
      'lightGray': super.lightGray,
      'lightMagenta': super.lightMagenta,
      'lime': super.lime,
      'magenta': super.magenta,
      'red': super.red,
      'white': super.white,
      'black': super.black,
      'yellow': super.yellow
    };
  }

  @override
  ColorText gold([String text]) => callMethod('gold', text);
  @override
  ColorText green([String text]) => callMethod('green', text);
  @override
  ColorText blue([String text]) => callMethod('blue', text);
  @override
  ColorText cyan([String text]) => callMethod('cyan', text);
  @override
  ColorText darkBlue([String text]) => callMethod('darkBlue', text);
  @override
  ColorText darkRed([String text]) => callMethod('darkRed', text);
  @override
  ColorText gray([String text]) => callMethod('gray', text);
  @override
  ColorText lightCyan([String text]) => callMethod('lightCyan', text);
  @override
  ColorText lightGray([String text]) => callMethod('lightGray', text);
  @override
  ColorText lightMagenta([String text]) => callMethod('lightMagenta', text);
  @override
  ColorText lime([String text]) => callMethod('lime', text);
  @override
  ColorText magenta([String text]) => callMethod('magenta', text);
  @override
  ColorText red([String text]) => callMethod('red', text);
  @override
  ColorText white([String text]) => callMethod('white', text);
  @override
  ColorText black([String text]) => callMethod('black', text);
  @override
  ColorText yellow([String text]) => callMethod('yellow', text);

  @override
  ColorText text(String text) => super.text(text);

  ColorText callMethod(String method, [String text]) {
    if (_method_mapping.containsKey(method)) {
      var callback = _method_mapping[method];
      if (text == null) {
        return callback().normal();
      } else {
        return callback().text(text).normal();
      }
    }

    return this;
  }
}
