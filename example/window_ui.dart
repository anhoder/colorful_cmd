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
        'Manager',
        'Test',
        'Test2'
      ],
      name: 'WIN_UI',
      // disableTimeDisplay: true,
      showWelcome: true,
      beforeEnterMenu: (ui) async {
        if (ui.curMenuStackLevel != 1) return Future.value([]);
        switch (ui.selectIndex) {
          case 0:
            await Future.delayed(Duration(seconds: 2));
            return Future.value(['Alipay', 'WeChat Pay']);
          case 1:
            Console.moveCursor(column: ui.startColumn, row: ui.startRow);
            Console.write(ColorText().blue('This is Collection').toString());
            return Future.value([]);
          default:
            return Future.value([]);
        }
      },
      beforeNextPage: (ui) async {
        await Future.delayed(Duration(seconds: 1));
        if (ui.menuPage == 1)  {
          var help = ui.menu.removeLast();
          ui.menu.addAll(['exampleTest', help]);
          return [];
        }
        return [];
      },
      menuPageSize: 10,
      // doubleColumn: false,
      // lang: Chinese() // lang
      );
  window.display();
}
