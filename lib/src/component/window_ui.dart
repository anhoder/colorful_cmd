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
  int menuPageSize;
  List<String> Function(WindowUI) beforeEnterMenu;
  int selectIndex = 0;
  bool progressRainbow;
  int page = 1;
  int pageSize = 10;

  String _menuTitle;
  bool _hasShownWelcome = false;
  int startRow;
  int startColumn;
  bool _doubleColumn;
  final List<_MenuItem> _menuStack = [];
  int _curMaxMenuRow;

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
      this.progressRainbow = true,
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

    if (defaultMenuTitle != null) _menuTitle = defaultMenuTitle;

    if (menu == null) {
      menu = ['Help'];
    } else {
      menu.add('Help');
    }
  }

  int get curMenuStackLevel => _menuStack.length;

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
    Console.hideCursor();
    Keyboard.bindKeys(['q', 'Q']).listen(_quit);
    Keyboard.bindKeys([KeyName.UP, 'k', 'K']).listen(_moveUp);
    Keyboard.bindKeys([KeyName.DOWN, 'j', 'J']).listen(_moveDown);
    Keyboard.bindKeys([KeyName.LEFT, 'h', 'H']).listen(_moveLeft);
    Keyboard.bindKeys([KeyName.RIGHT, 'l', 'L']).listen(_moveRight);
    Keyboard.bindKeys([KeyName.ENTER, 'n', 'N']).listen(enterMenu);
    Keyboard.bindKeys([KeyName.ESC, 'b', 'B']).listen(backMenu);
  }


  void enterMenu(_) {
    if (showWelcome && !_hasShownWelcome) return;
    if (selectIndex >= menu.length) return;
    _menuStack.add(_MenuItem(menu, selectIndex, _menuTitle));
    _earseMenu();
    _menuTitle = menu[selectIndex];

    if (_menuStack.length == 1 && selectIndex == menu.length - 1) {
      menu = [];
      selectIndex = 0;
      _menuTitle = 'Help';
      _displayMenuTitle();
      var row = startRow;
      localHelpInfo(lang).forEach((element) {
        Console.moveCursor(row: row, column: startColumn);
        Console.write(element);
        row++;
      });
      _curMaxMenuRow = row - 1;
    } else {
      menu = beforeEnterMenu == null ? [] : (beforeEnterMenu(this) ?? []);
      selectIndex = 0;
      _displayList();
    }
  }


  void backMenu(_) {
    if (showWelcome && !_hasShownWelcome) return;
    if (_menuStack.isEmpty) return;
    var menuItem = _menuStack.removeLast();

    _earseMenu();
    menu = menuItem.list;
    _curMaxMenuRow = _doubleColumn
        ? startRow + (menu.length / 2).ceil() - 1
        : startRow + menu.length - 1;
    selectIndex = menuItem.index;
    _menuTitle = menuItem.menuTitle;
    _earseMenu();
    _displayList();
  }


  void _earseMenu() {
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


  void _displayMenuTitle() {
    var menuTitle = toLocal(lang, _menuTitle);
    menuTitle = menuTitle.length > 50 ? menuTitle.substring(0, 50) : menuTitle;
    if (showTitle && startRow > 2) {
      Console.resetAll();
      var row = startRow > 4 ? startRow - 3 : 2;
      Console.moveCursor(row: row, column: startColumn);
      Console.setTextColor(Color.GREEN.id,
          bright: Color.GREEN.bright, xterm: Color.GREEN.xterm);
      Console.eraseLine();
      Console.write(menuTitle);
    } else if (!showTitle && startRow > 1) {
      var row = startRow > 3 ? startRow - 3 : 2;
      Console.moveCursor(row: row, column: startColumn);
      Console.setTextColor(Color.GREEN.id,
          bright: Color.GREEN.bright, xterm: Color.GREEN.xterm);
      Console.eraseLine();
      Console.write(menuTitle);
    }
  }


  void _displayList() {
    var width = Console.columns;
    var height = Console.rows;
    _doubleColumn = width >= 80;
    startRow = (height / 3).floor();
    startColumn = _doubleColumn
        ? ((width - 60) / 2).floor()
        : ((width - 20) / 2).floor();
    _curMaxMenuRow = _doubleColumn
        ? startRow + (menu.length / 2).ceil() - 1
        : startRow + menu.length - 1;

    _displayMenuTitle();

    Console.resetAll();
    Console.setTextColor(Color.WHITE.id, bright: false, xterm: false);
    var lines = _doubleColumn ? (menu.length / 2).ceil() : menu.length;
    for (var i = 0; i < lines; i++) {
      _displayLine(i);
    }
  }


  void _displayLine(int line) {
    Console.write('\r');
    var index = _doubleColumn ? line * 2 : line;
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
    }, Console.columns);
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
      Console.write('    ${index}. ${menuName}');
    }
  }


  void _quit(_) {
    Console.showCursor();
    close();
    Console.resetAll();
    Console.eraseDisplay();
    exit(0);
  }

  void _moveDown(_) {
    if (showWelcome && !_hasShownWelcome) return;
    int curLine;
    if (_doubleColumn) {
      if (selectIndex + 2 > menu.length - 1) {
        return;
      }
      selectIndex += 2;
      curLine = (selectIndex / 2).floor();
    } else {
      if (selectIndex + 1 > menu.length - 1) {
        return;
      }
      selectIndex++;
      curLine = selectIndex;
    }
    _displayLine(curLine - 1);
    _displayLine(curLine);
  }

  void _moveUp(_) {
    if (showWelcome && !_hasShownWelcome) return;
    int curLine;
    if (_doubleColumn) {
      if (selectIndex - 2 < 0) {
        return;
      }
      selectIndex -= 2;
      curLine = (selectIndex / 2).floor();
    } else {
      if (selectIndex - 1 < 0) {
        return;
      }
      selectIndex--;
      curLine = selectIndex;
    }
    _displayLine(curLine + 1);
    _displayLine(curLine);
  }

  void _moveLeft(_) {
    if (showWelcome && !_hasShownWelcome) return;
    if (!_doubleColumn || selectIndex % 2 == 0 || selectIndex - 1 < 0) {
      return;
    }
    selectIndex -= 1;
    var curLine = (selectIndex / 2).floor();
    _displayLine(curLine);
  }

  void _moveRight(_) {
    if (showWelcome && !_hasShownWelcome) return;
    if (!_doubleColumn ||
        selectIndex % 2 != 0 ||
        selectIndex + 1 > menu.length - 1) {
      return;
    }
    selectIndex += 1;
    var curLine = (selectIndex / 2).floor();
    _displayLine(curLine);
  }
}
