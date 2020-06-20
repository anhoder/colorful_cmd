part of component;

class WindowUI extends BaseWindow {
  String name;
  bool showWelcome;
  bool showTitle;
  String welcomeMsg;
  Color primaryColor;
  int welcomeDuration;
  ILang lang;
  List<String> menu;
  Future<List<String>> Function(WindowUI) beforeEnterMenu;
  Future<List<String>> Function(WindowUI) beforeNextPage;
  dynamic Function(WindowUI) init;
  int selectIndex = 0;
  bool progressRainbow;
  int menuPage = 1;
  int menuPageSize = 10;
  bool doubleColumn;
  bool disableTimeDisplay = false;
  dynamic pageData;

  String menuTitle;
  bool _hasShownWelcome = false;
  int startRow;
  int startColumn;
  bool _doubleColumn;
  final List<_MenuItem> menuStack = [];
  int _curMaxMenuRow;
  bool _isListenKey = true;

  WindowUI(
      {this.showTitle = true,
      this.showWelcome = true,
      this.welcomeMsg = 'win-ui',
      dynamic primaryColor = 'random',
      this.welcomeDuration = 2000,
      this.name = 'WIN_UI',
      this.menu,
      this.lang,
      defaultMenuTitle = 'Main Menu',
      this.beforeEnterMenu,
      this.beforeNextPage,
      this.disableTimeDisplay = false,
      this.progressRainbow = true,
      this.doubleColumn,
      this.init,
      this.menuPageSize = 10})
      : super(name) {
    if ((!(primaryColor is String) || primaryColor != 'random') &&
        !(primaryColor is Color)) {
      primaryColor = 'random';
    }
    if (primaryColor is String && primaryColor == 'random') {
      this.primaryColor = randomColor();
    } else if (primaryColor is Color) {
      this.primaryColor = primaryColor;
    }

    if (defaultMenuTitle != null) menuTitle = defaultMenuTitle;

    if (menu == null) {
      menu = ['Help'];
    } else {
      menu.add('Help');
    }

    Console.hideCursor();
  }

  int get curMenuStackLevel => menuStack.length;

  @override
  void draw() {
    Console.eraseDisplay(2);
    Console.moveCursor(row: 1, column: 1);

    if ((showWelcome && _hasShownWelcome && showTitle) ||
        (!showWelcome && showTitle)) _displayTitle();

    if (showWelcome && !_hasShownWelcome) {
      _displayWelcome(welcomeMsg);
      var progress = RainbowProgress(
          completeChar:
              progressRainbow ? '#' : ColorText().gray('#').toString(),
          forwardChar: progressRainbow ? '#' : ColorText().gray('#').toString(),
          leftDelimiter: ColorText().gray('[').toString(),
          rightDelimiter: ColorText().gray(']').toString(),
          showPercent: false,
          rainbow: progressRainbow);

      var interval = 20;
      Timer.periodic(Duration(milliseconds: interval), (timer) {
        Console.moveCursorDown(2);
        progress.update(
            ((timer.tick / (welcomeDuration / interval).round()) * 100)
                .round());
        Console.moveCursorUp(2);

        if (timer.tick >= (welcomeDuration / interval).round()) {
          _hasShownWelcome = true;
          timer.cancel();
          draw();
        } else {
          var column = ((Console.columns - 28) / 2).floor();
          Console.write('\r');
          Console.moveToColumn(column);
          Console.setTextColor(Color.GRAY.id,
              bright: Color.GRAY.bright, xterm: Color.GRAY.xterm);
          Console.write(
              ' Enter after ${(welcomeDuration / 1000 - timer.tick * (interval / 1000)).toStringAsFixed(1)} seconds... ');
        }
      });
    } else {
      _displayList();
    }
  }

  @override
  void initialize() {
    Keyboard.bindKeys(['q', 'Q']).listen(_quit);
    Keyboard.bindKeys([KeyName.UP, 'k', 'K']).listen(_moveUp);
    Keyboard.bindKeys([KeyName.DOWN, 'j', 'J']).listen(_moveDown);
    Keyboard.bindKeys([KeyName.LEFT, 'h', 'H']).listen(_moveLeft);
    Keyboard.bindKeys([KeyName.RIGHT, 'l', 'L']).listen(_moveRight);
    Keyboard.bindKeys([KeyName.ENTER, 'n', 'N']).listen(enterMenu);
    Keyboard.bindKeys([KeyName.ESC, 'b', 'B']).listen(backMenu);
    if (init != null) init(this);
  }

  WindowUI bindKey(String key, void Function(String key) func) {
    Keyboard.bindKey(key).listen(func);
    return this;
  }

  WindowUI bindKeys(List<String> keys, void Function(String key) func) {
    Keyboard.bindKeys(keys).listen(func);
    return this;
  }

  Future<void> enterMenu(_) async {
    if (!_isListenKey) return;
    if (showWelcome && !_hasShownWelcome) return;
    if (selectIndex >= menu.length) return;
    menuStack.add(_MenuItem(menu, selectIndex, menuTitle, pageData));
    var mTitle = menu[selectIndex];

    if (menuStack.length == 1 && selectIndex == menu.length - 1) {
      earseMenu();
      menu = [];
      selectIndex = 0;
      menuPage = 0;
      menuTitle = 'Help';
      displayMenuTitle();
      var row = startRow;
      localHelpInfo(lang).forEach((element) {
        Console.moveCursor(row: row, column: startColumn);
        Console.write(element);
        row++;
      });
      _curMaxMenuRow = row - 1;
    } else {
      _isListenKey = false;
      var row = startRow > (showTitle ? 4 : 3) ? startRow - 3 : 2;
      Console.moveCursor(row: row);
      Loader timer;
      if (!disableTimeDisplay) {
        timer = Loader();
        timer.start();
      }

      menu = beforeEnterMenu == null ? [] : (await beforeEnterMenu(this) ?? []);

      if (!disableTimeDisplay && timer != null) timer.stop();
      Console.moveCursor(row: row);
      Console.eraseLine();
      Console.adapter.echoMode = false;
      Console.adapter.lineMode = false;
      _isListenKey = true;

      earseMenu();
      menuTitle = mTitle;

      selectIndex = 0;
      menuPage = 1;
      _displayList();
    }
  }

  void backMenu(_) {
    if (!_isListenKey) return;
    if (showWelcome && !_hasShownWelcome) return;
    if (menuStack.isEmpty) return;
    var menuItem = menuStack.removeLast();

    earseMenu();
    menu = menuItem.list;
    _curMaxMenuRow = _doubleColumn
        ? startRow + (menu.length / 2).ceil() - 1
        : startRow + menu.length - 1;
    selectIndex = menuItem.index;
    menuPage = ((selectIndex + 1) / menuPageSize).ceil();
    menuTitle = menuItem.menuTitle;
    pageData = menuItem.curMenuData;
    earseMenu();
    _displayList();
  }

  void earseMenu() {
    _repeatFunction((i) {
      Console.moveCursor(row: startRow + i - 1);
      Console.eraseLine();
    }, _curMaxMenuRow - startRow + 1);
  }

  void _displayWelcome(String welcomeMsg) {
    var msg = formatChars(welcomeMsg);
    var lines = msg.split('\n');
    var width = lines.length > 1 ? lines[1].length : 0;
    var height = lines.length;
    var column = ((Console.columns - width) / 2).floor();
    var row = ((Console.rows - height) / 3).floor();

    Console.setTextColor(primaryColor.id,
        bright: primaryColor.bright, xterm: primaryColor.xterm);
    lines.forEach((line) {
      Console.moveCursor(column: column, row: row);
      Console.write(line);
      row++;
    });
    Console.moveCursor(column: column, row: row);
  }

  void _displayBorder() {
    var width = Console.columns;

    Console.resetAll();
    _repeatFunction((i) {
      Console.setTextColor(primaryColor.id,
          bright: primaryColor.bright, xterm: primaryColor.xterm);
      Console.write('─');
    }, width);
  }

  void _displayTitle() {
    _displayBorder();
    Console.resetAll();
    Console.setTextColor(primaryColor.id,
        bright: true, xterm: primaryColor.xterm);
    Console.moveCursor(
      row: 1,
      column: (Console.columns / 2).round() - (title.length / 2).round(),
    );
    Console.write(' ${toLocal(lang, title)} ');
    _repeatFunction((i) => Console.write('\n'), Console.rows - 1);
    Console.moveCursor(row: 2, column: 1);
    Console.centerCursor(row: true);
    Console.resetBackgroundColor();
  }

  void displayMenuTitle() {
    var title = toLocal(lang, menuTitle);
    title = title.length > 50 ? title.substring(0, 50) : title;
    if (showTitle && startRow > 2) {
      Console.resetAll();
      var row = startRow > 4 ? startRow - 3 : 2;
      Console.moveCursor(row: row, column: startColumn);
      Console.setTextColor(Color.GREEN.id,
          bright: Color.GREEN.bright, xterm: Color.GREEN.xterm);
      Console.eraseLine();
      Console.write(title);
    } else if (!showTitle && startRow > 1) {
      var row = startRow > 3 ? startRow - 3 : 2;
      Console.moveCursor(row: row, column: startColumn);
      Console.setTextColor(Color.GREEN.id,
          bright: Color.GREEN.bright, xterm: Color.GREEN.xterm);
      Console.eraseLine();
      Console.write(title);
    }
  }

  void _displayList() {
    var width = Console.columns;
    var height = Console.rows;
    _doubleColumn = doubleColumn ?? width >= 80;
    startRow = (height / 3).floor();
    startColumn =
        _doubleColumn ? ((width - 60) / 2).floor() : ((width - 20) / 2).floor();
    _curMaxMenuRow = _doubleColumn
        ? startRow + (menu.length / 2).ceil() - 1
        : startRow + menu.length - 1;

    displayMenuTitle();

    Console.resetAll();
    Console.setTextColor(Color.WHITE.id, bright: false, xterm: false);
    var curMenus = menu.getRange((menuPage - 1) * menuPageSize,
        min(menu.length, menuPage * menuPageSize));
    var lines = _doubleColumn ? (curMenus.length / 2).ceil() : curMenus.length;
    for (var i = 0; i < lines; i++) {
      _displayLine(i);
    }
  }

  void _displayLine(int line) {
    Console.write('\r');
    var index = _doubleColumn
        ? line * 2 + (menuPage - 1) * menuPageSize
        : line + (menuPage - 1) * menuPageSize;
    index = min(menu.length - 1, index);
    Console.moveCursor(row: startRow + line, column: startColumn);
    _displayItem(index);
    if (_doubleColumn && index < menu.length - 1) {
      Console.moveCursor(row: startRow + line, column: startColumn + 40);
      _displayItem(index + 1);
    }
    _repeatFunction((i) {
      Console.write(' ');
      Console.moveCursorBack();
      Console.moveCursorForward();
    }, startColumn - 40);
  }

  void _displayItem(int index) {
    Console.moveCursorBack(4);
    var menuName = toLocal(lang, menu[index]);
    menuName = menuName.length > 50 ? menuName.substring(0, 50) : menuName;
    if (selectIndex == index) {
      Console.setTextColor(primaryColor.id,
          bright: primaryColor.bright, xterm: primaryColor.xterm);
      Console.write(' => ${index}. ${menuName}');
      Console.resetAll();
    } else {
      Console.write(ColorText().normal().toString() + '    ${index}. ${menuName}');
    }
  }

  void _prePage() {
    if (!_isListenKey) return;
    if (menuPage <= 1) return;
    menuPage--;
    earseMenu();
    _displayList();
  }

  Future<void> _nextPage() async {
    if (!_isListenKey) return;
    if (menuPage >= (menu.length / menuPageSize).ceil()) return;

    _isListenKey = false;
    var row = startRow > (showTitle ? 4 : 3) ? startRow - 3 : 2;
    Console.moveCursor(row: row);
    Loader timer;
    if (!disableTimeDisplay) {
      timer = Loader();
      timer.start();
    }

    var appendMenus = beforeNextPage == null ? <String>[] : (await beforeNextPage(this) ?? <String>[]);
    
    if (!disableTimeDisplay && timer != null) timer.stop();
    _isListenKey = true;
    Console.moveCursor(row: row);
    Console.eraseLine();
    Console.adapter.echoMode = false;
    Console.adapter.lineMode = false;


    menu.addAll(appendMenus);
    menuPage++;
    earseMenu();
    _displayList();
  }

  void _quit(_) {
    Console.showCursor();
    close();
    Console.resetAll();
    Console.eraseDisplay();
    exit(0);
  }

  void _moveDown(_) {
    if (!_isListenKey) return;
    if (showWelcome && !_hasShownWelcome) return;
    int curLine;
    if (_doubleColumn) {
      if (selectIndex + 2 > menu.length - 1) {
        return;
      }
      selectIndex += 2;
      curLine = ((selectIndex - (menuPage - 1) * menuPageSize) / 2).floor();
    } else {
      if (selectIndex + 1 > menu.length - 1) {
        return;
      }
      selectIndex++;
      curLine = selectIndex - (menuPage - 1) * menuPageSize;
    }
    if (selectIndex >= menuPage * menuPageSize) {
      _nextPage();
    } else {
      _displayLine(curLine - 1);
      _displayLine(curLine);
    }
  }

  void _moveUp(_) {
    if (!_isListenKey) return;
    if (showWelcome && !_hasShownWelcome) return;
    int curLine;
    if (_doubleColumn) {
      if (selectIndex - 2 < 0) {
        return;
      }
      selectIndex -= 2;
      curLine = ((selectIndex - (menuPage - 1) * menuPageSize) / 2).floor();
    } else {
      if (selectIndex - 1 < 0) {
        return;
      }
      selectIndex--;
      curLine = selectIndex - (menuPage - 1) * menuPageSize;
    }
    if (selectIndex < (menuPage - 1) * menuPageSize) {
      _prePage();
    } else {
      _displayLine(curLine + 1);
      _displayLine(curLine);
    }
  }

  void _moveLeft(_) {
    if (!_isListenKey) return;
    if (showWelcome && !_hasShownWelcome) return;
    if (!_doubleColumn || selectIndex % 2 == 0 || selectIndex - 1 < 0) {
      return;
    }
    selectIndex -= 1;
    var curLine = ((selectIndex - (menuPage - 1) * menuPageSize) / 2).floor();
    _displayLine(curLine);
  }

  void _moveRight(_) {
    if (!_isListenKey) return;
    if (showWelcome && !_hasShownWelcome) return;
    if (!_doubleColumn ||
        selectIndex % 2 != 0 ||
        selectIndex + 1 > menu.length - 1) {
      return;
    }
    selectIndex += 1;
    var curLine = ((selectIndex - (menuPage - 1) * menuPageSize) / 2).floor();
    _displayLine(curLine);
  }
}
