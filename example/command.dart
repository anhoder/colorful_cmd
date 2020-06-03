import 'package:colorful_cmd/command.dart';
import 'command/root_command.dart';
import 'command/test_group.dart';

void main(List<String> args) {
  var kernel = ConsoleKernel();
  kernel.addCommands([RootCommand()])
        .addGroup(TestGroup())
        // .setDefaultCommand(RootCommand())
        .run(args);
}
