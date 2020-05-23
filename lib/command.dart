library command;

import 'dart:io';
import 'dart:math';
import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:args/src/utils.dart';
import 'package:colorful_cmd/exception.dart';
import 'package:colorful_cmd/logger.dart';
import 'package:colorful_cmd/utils.dart';
import 'package:console/console.dart';

part 'src/interface/i_group.dart';
part 'src/interface/i_input.dart';
part 'src/interface/i_output.dart';
part 'src/interface/i_cmd.dart';
part 'src/command/flag.dart';
part 'src/command/option.dart';
part 'src/kernel/console_kernel.dart';
