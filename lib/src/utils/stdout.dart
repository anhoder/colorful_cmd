part of utils;

  /// print info
  void printInfo(Object text, [Color color = Color.CYAN]) => ColorText().setColor(color).text(text.toString()).normal().print();

  void printDebug(Object text) => printInfo(text, Color.GREEN);

  void printWarning(Object text) => printInfo(text, Color.YELLOW);

  void printTrace(Object text) => printInfo(text, Color.MAGENTA);

  void printError(Object text) => printInfo(text, Color.RED);