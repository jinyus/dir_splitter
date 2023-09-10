import 'package:args/command_runner.dart';
import 'package:dir_splitter/dir_splitter.dart';
import 'package:dir_splitter/src/version.dart';

class VersionCommand extends Command {
  // The [name] and [description] properties must be defined by every
  // subclass.
  @override
  final name = "version";
  @override
  final description = "Outputs the version of this tool";

  // [run] may also return a Future.
  @override
  void run() {
    echo('dartsplitter version:', packageVersion.yellow);
  }
}
