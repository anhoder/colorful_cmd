import 'dart:async';

import 'package:colorful_cmd/component.dart';
import 'package:console/console.dart';

void main(List<String> args) {
  var progress = RainbowProgress(completeChar: '#', forwardChar: '#');
  Timer.periodic(Duration(milliseconds: 20), (timer) {
    progress.update(progress.current + 1);
    if (progress.current >= 100) timer.cancel();
  });
}