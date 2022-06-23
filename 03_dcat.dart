// 命令行（https://dart.cn/tutorials/server/cmdline#overview-of-the-dcat-app-code）

import 'dart:io';
import 'dart:convert';
import 'package:args/args.dart';

const lineNumber = 'line-number';

void main(List<String> args) {
  exitCode = 0;
  final parser = ArgParser()..addFlag(lineNumber, negatable: false, abbr: 'n');

  ArgResults argResults = parser.parse(args);

  final paths = argResults.rest; // 剩余的命令行参数

  dcat(paths, showLineNumbers: argResults[lineNumber] as bool);
}

Future<void> dcat(List<String> paths, {bool showLineNumbers = false}) async {
  if (paths.isEmpty) {
    print('type exit to quit.');
    while (true) {
      stdout.write('>');
      String? line = stdin.readLineSync();
      if (line?.toLowerCase() == 'exit') {
        print('有缘再见！');
        break;
      }
      print('假装已经执行${line}命令！');
    }
  } else {
    for (final path in paths) {
      var lineNumber = 1;
      final lines = utf8.decoder
          .bind(File(path).openRead())
          .transform(const LineSplitter());

      try {
        await for (final line in lines) {
          if (showLineNumbers) {
            stdout.write('${lineNumber++}');
          }
          stdout.writeln(line);
        }
      } catch (_) {
        await _handleError(path);
      }
    }
  }
}

Future<void> _handleError(String path) async {
  if (await FileSystemEntity.isDirectory(path)) {
    stderr.writeln('ErrorL $path is a direcory');
  } else {
    exitCode = 2;
  }
}
