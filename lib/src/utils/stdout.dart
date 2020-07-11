part of utils;

/// print info
void printInfo(Object text, [Color color]) {
  color ??= Colors.CYAN;
  ColorText().setColor(color).text(text.toString()).normal().print();
}

void printDebug(Object text) => printInfo(text, Colors.GREEN);

void printWarning(Object text) => printInfo(text, Colors.YELLOW);

void printTrace(Object text) => printInfo(text, Colors.MAGENTA);

void printError(Object text) => printInfo(text, Colors.RED);
