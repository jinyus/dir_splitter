# dir_splitter

Split large directories into parts of a specified maximum size.This is a dart port of my dirsplitter tool.

[Go version](https://github.com/jinyus/dirsplitter) (more binaries available)<br>

## How to run:

```bash
dart bin/main.dart --help


# download the binary from the releases page
dir_splitter --help
```

## USAGE:

```text
Usage: dir_splitter <command> [arguments] DIRECTORY

Global options:
-h, --help    Print this usage information.

Available commands:
  reverse   Reverse a splitted directory
  split     Split a directory into parts of a given size
  version   Outputs the version of this tool

Run "dir_splitter help <command>" for more information about a command.
```

## SPLIT USAGE:

```text
Split a directory into parts of a given size

Usage: dir_splitter split [arguments]
-h, --help    Print this usage information.
-m, --max     Size of each part in GB
              (defaults to "5.0")
```

### example:

```bash
dir_splitter split --max 0.5 ./mylarge2GBdirectory

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
dir_splitter reverse ./mylarge2GBdirectory

```
