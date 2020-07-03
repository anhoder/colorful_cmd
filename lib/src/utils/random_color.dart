part of utils;

List<Color> COLOR_MAP = [
  Colors.RED,
  Colors.DARK_RED,
  Colors.LIME,
  Colors.GREEN,
  Colors.GOLD,
  Colors.YELLOW,
  Colors.BLUE,
  Colors.DARK_BLUE,
  Colors.MAGENTA,
  Colors.LIGHT_MAGENTA,
  Colors.CYAN,
  Colors.LIGHT_CYAN,
  Colors.WHITE
];

Color randomColor() {
  var index = Random().nextInt(COLOR_MAP.length - 1);
  return COLOR_MAP[index];
}
