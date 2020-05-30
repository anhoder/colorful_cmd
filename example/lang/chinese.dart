import 'package:colorful_cmd/lang.dart';

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
h|H: 左
j|J: 下
k|K: 上
l|L: 右
n|N: 进入选中的菜单
b|B: 返回上一级菜单
q|Q: 退出
  ''';
}
