import 'package:colorful_cmd/src/component/loader.dart';

void main(List<String> args) {
  var loader = Loader();
  loader.start();
  Future.delayed(Duration(seconds: 2)).then((_) {
    loader.stop();
  });
}