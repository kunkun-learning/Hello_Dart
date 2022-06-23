import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;
import 'package:shelf_static/shelf_static.dart' as shelf_static;

Future main() async {
  // 若没有设置端口，则设为8080（设在环境变量中）
  final port = int.parse(Platform.environment['PORT'] ?? '8080');

  // 将请求按顺序转发给好几个处理器，链式地返回第一个能够正确处理该请求的响应
  final cascade = Cascade()
      // 先转发给静态文件处理器
      .add(_staticHandler)
      // 静态文件处理器无法正确处理则转发给路由
      .add(_router);

  final server = await shelf_io.serve(
    // 使用一个记录日志的中间件
    logRequests()
        // 将上面创建的cascade加入监听
        .addHandler(cascade.handler),
    InternetAddress.anyIPv4, // 配置连接的安全策略，允许所有IPv4地址访问
    port,
  );

  // 控制台输出连接信息
  print('Serving at http://${server.address.host}:${server.port}');
}

// 使用shelf库创建提供静态文件的处理器
final _staticHandler =
    shelf_static.createStaticHandler('public', defaultDocument: 'index.html');

// 将不同地址路由到对应的类
final _router = shelf_router.Router()
  ..get('/helloworld', _helloWorldHandler)
  ..get(
    '/time',
    (request) => Response.ok(DateTime.now().toUtc().toIso8601String()),
  )
  ..get('/sum/<a|[0-9]+>/<b|[0-9]+>', _sumHandler); // 路由时就已经生成匹配组了

// HelloWorld的处理类，直接返回文字信息“Hello, World!”即可
Response _helloWorldHandler(Request request) => Response.ok('Hello, World!');

// 将两个数相加的处理器，直接从路由接受a、b即可，是字符串类型的
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
