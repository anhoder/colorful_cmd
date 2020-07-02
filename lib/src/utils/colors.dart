part of utils;

abstract class Colors {

  static bool is256Color = false;

  static void init() {
    var env = Platform.environment;
    if (!env.containsKey('TERM')) return;
    if (!env['TERM'].contains('256')) return;
    is256Color = true;
  }

  static const Color BLACK = Color(0);
  static const Color GRAY = Color(0, bright: true);
  static const Color RED = Color(1);
  static const Color DARK_RED = Color(1, bright: true);
  static const Color LIME = Color(2, bright: true);
  static const Color GREEN = Color(2);
  static const Color GOLD = Color(3);
  static const Color YELLOW = Color(3, bright: true);
  static const Color BLUE = Color(4, bright: true);
  static const Color DARK_BLUE = Color(4);
  static const Color MAGENTA = Color(5);
  static const Color LIGHT_MAGENTA = Color(5, bright: true);
  static const Color CYAN = Color(6);
  static const Color LIGHT_CYAN = Color(6, bright: true);
  static const Color LIGHT_GRAY = Color(7);
  static const Color WHITE = Color(7, bright: true);
}