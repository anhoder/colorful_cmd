
import 'package:colorful_cmd/component.dart';

void main(List<String> args) {
  var loader = Loader();
  loader.start();
  Future.delayed(Duration(seconds: 2)).then((_) {
    loader.stop();
  });
}