part of utils;

const List<Color> COLOR_MAP = [
  Color.RED,
  Color.DARK_RED,
  Color.LIME,
  Color.GREEN,
  Color.GOLD,
  Color.YELLOW,
  Color.BLUE,
  Color.DARK_BLUE,
  Color.MAGENTA,
  Color.LIGHT_MAGENTA,
  Color.CYAN,
  Color.LIGHT_CYAN,
  Color.WHITE
];

Color randomColor() {
  var index = Random().nextInt(COLOR_MAP.length - 1);
  return COLOR_MAP[index];
}
