//静态服务器(https://github.com/dart-lang/samples/blob/master/server/simple/bin/server.dart)
import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;
import 'package:shelf_static/shelf_static.dart' as shelf_static;

Future main() async {
  // 若没有设置端口，则设为8080
  final port = int.parse(Platform.environment['PORT'] ?? '8080');

  // 将请求按顺序转发给好几个处理器，链式地返回第一个能够正确处理该请求的响应
  final cascade = Cascade().add(_staticHandler).add(_router);

  final server = await shelf_io.serve(
    logRequests() // 使用一个记录日志的中间件
        .addHandler(cascade.handler),
    InternetAddress.anyIPv4, // 配置连接的安全策略，允许所有IPv4地址访问
    port,
  );

  // 控制台输出连接信息
  print('Serving at http://${server.address.host}:${server.port}');
}

// 提供没有请求时的默认值，就是一个html页面
final _staticHandler =
    shelf_static.createStaticHandler('public', defaultDocument: 'index.html');

// 将不同地址路由到对应的类
final _router = shelf_router.Router()
  ..get('/shizhenkun', _helloWorldHandler)
  ..get(
      '/sum/<a|[0-9]+>/<b|[0-9]+>', _sumHandler); // 正则表达式把动态转为静态，静态时会有缓存，提高访问速度

// shizhenkun的处理器
Response _helloWorldHandler(Request request) => Response.ok('shizhenkun');

// 将两个数相加的处理器
Response _sumHandler(request, String a, String b) {
  final aNum = int.parse(a);
  final bNum = int.parse(b);
  return Response.ok(
    const JsonEncoder.withIndent(' ')
        .convert({'a': aNum, 'b': bNum, 'sum': aNum + bNum}),
    headers: {
      // 设置一些头信息，声明存活时间
      'content-type': 'application/json',
      'Cache-Control': 'public, max-age=604800',
    },
  );
}
