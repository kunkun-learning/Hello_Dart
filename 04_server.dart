// 静态服务器 （）

import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;
import 'package:shelf_static/shelf_static.dart' as shelf_static;

Future<void> main(List<String> args) async {
  // 从环境变量里读取 PORT 变量用作端口，斗则用 '8080'
  // ?? 快捷操作符（）
  final port = int.parse(Platform.environment['PORT'] ?? '8080');

  // 一个请求队列（）
  final cascade = Cascade().add(_staticHandler);

  // 启动一个 HTTP 服务（）
  final server = await shelf_io.serve(
      // 处理请求的时候，顺便做个日志（）
      logRequests().addHandler(cascade.handler),
      InternetAddress.anyIPv4,
      port);

  print(
      'Serving at http://${server.address.host}:${server.port}, CTRL+C to stop.');
}

final _staticHandler =
    shelf_static.createStaticHandler('public', defaultDocument: 'index.html');
