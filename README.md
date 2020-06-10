A library for building a beautiful command line application in dart.

![GitHub repo size](https://img.shields.io/github/repo-size/AlanAlbert/colorful_cmd)
![GitHub](https://img.shields.io/github/license/AlanAlbert/colorful_cmd)
![Last Tag](https://badgen.net/github/tag/alanalbert/colorful_cmd)
![GitHub last commit](https://badgen.net/github/last-commit/alanalbert/colorful_cmd)

![Support](https://badgen.net/pub/dart-platform/colorful_cmd)
![Pub Version](https://img.shields.io/pub/v/colorful_cmd)


![GitHub stars](https://img.shields.io/github/stars/AlanAlbert/colorful_cmd?style=social)
![GitHub forks](https://img.shields.io/github/forks/AlanAlbert/colorful_cmd?style=social)

## Dependency

* console
* args

## Preview


### Diff OS

* Ubuntu 
![Ubuntu](./example/preview/ubuntu.png)
* Windows
![Windows](./example/preview/windows.png)
* Mac
![Mac](./example/preview/mac.png)

### ColorText

![ColorText](./example/preview/color_text.png)

### Command

![Command](./example/preview/command.png)

### RainbowProgress

![RainbowProgress](./example/preview/rainbow_progress.png)

### WindowUI

![WindowUI](./example/preview/window_ui.png)
![WindowUI2](./example/preview/window_ui2.png)


## Usage


A simple usage example:

```dart
import 'package:dart_command/command.dart';
import 'package:dart_command/logger.dart';

void main(List<String> args) {
  var kernel = ConsoleKernel();
  kernel.addCommands([RootCommand()])
        .run(args);
}

class RootCommand extends ICmd {

  @override
  String name = 'root';

  @override
  String description = 'root command, without group';

  @override
  List<Flag> get flags => null;

  @override
  List<ILogHandler> get logHandlers => null;

  @override
  List<Option> get options => null;
  
  @override
  void run() {
    warning(description);
    var colorText = ColorText();
    colorText
      .gold('\n\n\ngold\n')
      .green('green\n')
      .blue('blue\n')
      .cyan('cyan\n')
      .darkBlue('darkBlue\n')
      .darkRed('darkRed\n')
      .gray('gray\n')
      .lightCyan('lightCyan\n')
      .lightGray('lightGray\n')
      .lightMagenta('lightMagenta\n')
      .lime('lime\n')
      .magenta('magenta\n')
      .red('red\n')
      .white('white\n')
      .black('black\n')
      .yellow('yellow\n')
      .print();
  }
}
```

**For more examples, see the example folder.**
