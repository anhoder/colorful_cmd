import 'package:colorful_cmd/lang.dart';
import 'package:colorful_cmd/utils.dart';

class Chinese implements ILang {
  @override
  Map<String, String> get wordsMap => {
        'Help': '帮助',
        'Pay': '支付',
        'Collection': '收藏',
        'Photo': '相册',
        'Card': '卡包',
        'Emoji': '表情',
        'Setting': '设置',
        'Test': '测试',
        'Product': '产品',
        'Developer': '开发者',
        'Manager': '管理员',
        'Main Menu': '主菜单',
        'WIN_UI': '窗口UI',
        'Alipay': '支付宝',
        'WeChat Pay': '微信支付'
      };

  @override
  String get helpInfo => '''
${ColorText().cyan('h / H / LEFT').toString()}         ${ColorText().blue('左').toString()}
${ColorText().cyan('l / L / RIGHT').toString()}        ${ColorText().blue('右').toString()}
${ColorText().cyan('j / J / DOWN').toString()}         ${ColorText().blue('下').toString()}
${ColorText().cyan('k / K / UP').toString()}           ${ColorText().blue('上').toString()}
${ColorText().cyan('n / N / ENTER').toString()}        ${ColorText().blue('进入选中的菜单项').toString()}
${ColorText().cyan('b / B / ESC').toString()}          ${ColorText().blue('返回上级菜单').toString()}
${ColorText().cyan('q / Q').toString()}                ${ColorText().blue('退出').toString()}
''';
}
