import 'package:command/command.dart';

import 'bar_command.dart';
import 'foo_command.dart';

class TestGroup extends IGroup {

  @override
  String get name => 'group';

  @override
  List<ICmd> get commands => [
    FooCommand(),
    BarCommand()
  ];

  @override
  List<IGroup> get groups => null;
}