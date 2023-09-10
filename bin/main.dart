import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_splitter/dart_splitter.dart';

void main(List<String> arguments) {
  CommandRunner('dart_splitter', "Split Directories")
    ..addCommand(SplitCommand())
    ..addCommand(ReverseCommand())
    ..addCommand(VersionCommand())
    ..run(arguments).catchError((error) {
      if (error is! UsageException) throw error;
      print(error);
      exit(64);
    });
}
