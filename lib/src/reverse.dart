import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_splitter/dart_splitter.dart';
import 'package:path/path.dart' as p;

class ReverseCommand extends Command {
  @override
  final name = "reverse";
  @override
  final description = "Reverse a splitted directory";

  @override
  void run() {
    final path = argResults?.rest.firstOrNull;

    if (path == null) {
      echo('Error'.red, 'Please provide a directory to split');
      print(argParser.usage);
      exit(64);
    } else if (!FileSystemEntity.isDirectorySync(path)) {
      echo('Error'.red, '"$path" is not a directory');
      print(argParser.usage);
      exit(64);
    }

    final dir = Directory(path);

    confirmOperation('Reverse split "${dir.absolute.path.yellow}"?');

    _reverseSplitDir(dir);
  }
}

void _reverseSplitDir(Directory dir) {
  // moves ./dir/part1/textfiles/file.txt to ./dir/textfiles/file.txt

  try {
    // use String so no duplicates and Directory doesn't override == operator
    Set<String> foldersToRemove = {};

    dir.listSync().whereType<Directory>().where((item) => item.isPartDir()).forEach((subDir) {
      subDir.listSync(recursive: true).whereType<File>().forEach((f) {
        final newPath = p.join(dir.path, p.relative(f.path, from: subDir.path));

        f.renameSync(newPath);

        foldersToRemove.add(subDir.path);
      });
    });

    echo('Done'.green, 'Reverse split ${foldersToRemove.length} parts');

    foldersToRemove.map((e) => Directory(e)).forEach((d) {
      d.deleteSync();
    });
  } catch (e) {
    print('Failed to move file');
    print(e);
  }
}
