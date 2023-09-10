import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_splitter/src/utils.dart';
import 'package:path/path.dart' as p;

class SplitCommand extends Command {
  @override
  final name = "split";
  @override
  final description = "Split a directory into parts of a given size";

  SplitCommand() {
    argParser.addOption(
      'max',
      abbr: 'm',
      defaultsTo: '5.0',
      help: 'Size of each part in GB',
    );
  }

  @override
  void run() {
    final path = argResults?.rest.firstOrNull;
    final max = double.tryParse(argResults?['max'] as String);

    if (path == null) {
      echo('Error'.red, 'Please provide a directory to split');
      print(argParser.usage);
      exit(64);
    } else if (!FileSystemEntity.isDirectorySync(path)) {
      echo('Error'.red, '"$path" is not a directory');
      print(argParser.usage);
      exit(64);
    } else if (max == null) {
      echo('Error'.red, '"${argResults?['max']}" is not a valid max size');
      print(argParser.usage);
      exit(64);
    }

    final dir = Directory(path);

    confirmOperation('Split "${dir.absolute.path.yellow}" into parts of $max GB?');

    _splitDir(dir, max);
  }
}

void _splitDir(Directory dir, double max) {
  var tracker = {1: 0};
  var currentPart = 1;
  var filesMoved = 0;
  var failedOps = 0;
  var skippedFiles = 0;

  final maxSize = max * 1024 * 1024 * 1024;

  dir.listSync(recursive: true).whereType<File>().forEach((file) {
    if (file.parent.isPartDir()) {
      skippedFiles += 1;
      return;
    }

    try {
      tracker.update(
        currentPart,
        (value) => value + file.lengthSync(),
        // ifAbsent: file.lengthSync,
      );

      if (tracker[currentPart]! >= maxSize) {
        currentPart += 1;
        tracker[currentPart] = 0;
      }

      final partDir = Directory(p.join(dir.path, 'part$currentPart'));

      final newPath = p.join(partDir.path, p.relative(file.path, from: dir.path));

      partDir.createSync(recursive: true);
      file.renameSync(newPath);

      filesMoved += 1;
    } catch (e) {
      print('Failed to move file: ${file.path}');
      print(e);

      failedOps += 1;
    }
  });

  print('Results:');
  echo('files moved:'.green, filesMoved.toString());
  echo('Skipped files in part directory:'.cyan, skippedFiles.toString());
  echo('failed operations:'.red, failedOps.toString());
}
