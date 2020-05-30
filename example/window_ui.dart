import 'dart:convert';

import 'package:colorful_cmd/component.dart';
import 'package:colorful_cmd/utils.dart';
import 'package:console/console.dart';

import 'lang/chinese.dart';

void main(List<String> args) {
  var window = WindowUI(
    welcomeMsg: 'WIN-UI',
    menu: [
      'Pay',
      'Collection',
      'Photo',
      'Card',
      'Emoji',
      'Setting',
      'Test',
      'Product',
      'Developer',
      'Manager'
    ],
    name: 'WIN_UI',
    beforeEnterMenu: (ui) {
      if (ui.curMenuStackLevel != 1) return [];
      switch (ui.selectIndex) {
        case 0:
          return ['Alipay', 'WeChat Pay'];
        case 1:
          Console.moveCursor(column: ui.startColumn, row: ui.startRow);
          Console.write(ColorText().blue('This is Collection').toString());
          return [];
        default:
          return [];
      }
    },
    lang: Chinese() // lang
  );
  window.display();
}
