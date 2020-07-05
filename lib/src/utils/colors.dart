part of utils;

abstract class Colors {

  static bool isXterm;

  static void init() {
    var env = Platform.environment;
    if (!env.containsKey('TERM') || !env['TERM'].contains('256')) {
      isXterm = false;
      return;
    }
    isXterm = true;
  }

  static Color get BLACK {
    if (isXterm == null) init();
    return Color(0, xterm: isXterm);
  } 

  static Color get GRAY {
    if (isXterm == null) init();
    return isXterm ? Color(8, xterm: true) : Color(0, bright: true);
  }

  static Color get RED {
    if (isXterm == null) init();
    return isXterm ? Color(9, xterm: true) : Color(1, bright: true);
  }

  static Color get DARK_RED {
    if (isXterm == null) init();
    return Color(1, xterm: isXterm);
  }

  static Color get LIME {
    if (isXterm == null) init();
    return isXterm ? Color(10, xterm: true) : Color(2, bright: true);
  }

  static Color get GREEN {
    if (isXterm == null) init();
    return Color(2, xterm: isXterm);
  }

  static Color get GOLD {
    if (isXterm == null) init();
    return Color(3, xterm: isXterm);
  }

  static Color get YELLOW {
    if (isXterm == null) init();
    return isXterm ? Color(11, xterm: true) : Color(3, bright: true);
  }

  static Color get BLUE {
    if (isXterm == null) init();
    return isXterm ? Color(12, xterm: true) : Color(4, bright: true);
  }

  static Color get DARK_BLUE {
    if (isXterm == null) init();
    return Color(4, xterm: isXterm);
  }

  static Color get LIGHT_MAGENTA {
    if (isXterm == null) init();
    return isXterm ? Color(13, xterm: true) : Color(5, bright: true);
  }

  static Color get MAGENTA {
    if (isXterm == null) init();
    return Color(5, xterm: isXterm);
  } 

  static Color get LIGHT_CYAN {
    if (isXterm == null) init();
    return isXterm ? Color(14, xterm: true) : Color(6, bright: true);
  }

  static Color get CYAN {
    if (isXterm == null) init();
    return Color(6, xterm: isXterm);
  }

  static Color get LIGHT_GRAY {
    if (isXterm == null) init();
    return isXterm ? Color(15, xterm: true) : Color(7, bright: true);
  }

  static Color get WHITE {
    if (isXterm == null) init();
    return Color(7, xterm: isXterm);
  }
}