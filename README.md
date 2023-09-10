# dart_splitter

Split large directories into parts of a specified maximum size.

## How to run:

#### download the binary from the release page

```bash
dart_splitter --help
```

## USAGE:

```text
Usage: dart_splitter <command> [arguments] DIRECTORY

Global options:
-h, --help    Print this usage information.

Available commands:
  reverse   Reverse a splitted directory
  split     Split a directory into parts of a given size
  version   Outputs the version of this tool

Run "dart_splitter help <command>" for more information about a command.
```

## SPLIT USAGE:

```text
Split a directory into parts of a given size

Usage: dart_splitter split [arguments]
-h, --help    Print this usage information.
-m, --max     Size of each part in GB
              (defaults to "5.0")
```

### example:

```bash
dart_splitter split --max 0.5 ./mylarge2GBdirectory

This will yield the following directory structure:

📂mylarge2GBdirectory
 |- 📂part1
 |- 📂part2
 |- 📂part3
 |- 📂part4

with each part being a maximum of 500MB in size.
```

Undo splitting

```bash
dart_splitter reverse ./mylarge2GBdirectory

```