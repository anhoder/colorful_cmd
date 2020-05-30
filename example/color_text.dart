import 'package:colorful_cmd/utils.dart';
import 'package:console/console.dart';

void main(List<String> args) {
  var colorText = ColorText();
  colorText
      .gold('gold\n')
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
      .setBackgroundColor(Color.GREEN.id)
      .white('green bg color')
      .print();
}
