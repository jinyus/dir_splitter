import 'dart:io';

extension TextColor on String {
  String get red => '\x1B[31m$this\x1B[0m';
  String get green => '\x1B[32m$this\x1B[0m';
  String get yellow => '\x1B[33m$this\x1B[0m';
  String get blue => '\x1B[34m$this\x1B[0m';
  String get magenta => '\x1B[35m$this\x1B[0m';
  String get cyan => '\x1B[36m$this\x1B[0m';
  String get white => '\x1B[37m$this\x1B[0m';
}

void echo(String t1, [String? t2, String? t3, String? t4, String? t5]) =>
    print([t1, t2, t3, t4, t5].whereType<String>().join(' '));

void confirmOperation(String question) {
  echo(question, '[Y/n]'.cyan);

  final input = stdin.readLineSync();

  if (!{'y', 'yes', ''}.contains(input?.toLowerCase().trim())) {
    echo('Operation cancelled'.red);
    exit(0);
  }
}

final partRe = RegExp(r'part(\d+)$');

extension PartX on Directory {
  bool isPartDir() => partRe.hasMatch(path);
}
