import 'package:colorful_cmd/component.dart';

void main(List<String> args) {
  var window = WindowUI(welcomeMsg: 'WIN-UI', menu: [
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
  ]);
  window.display();
}