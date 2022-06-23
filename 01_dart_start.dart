import 'dart:async';
import 'dart:io';
import 'dart:math';

// 变量 (https://dart.cn/samples#variables)
void variables() {
  print('\n');
  print('*' * 50);
  print('\n变量测试:');
  var name = 'ShiZhenKun';
  var year = 2002;
  var antennaDiameter = 3.7;
  var flybyObjects = ['Jupiter', 'Saturn', 'Uranus', 'Neptune'];
  var image = {
    'tags': ['saturn'],
    'url': '//path/to/saturn.jpg'
  };

  print(
      'name: $name, year: $year, antennaDiameter: $antennaDiameter, flybyObjects: $flybyObjects, image: $image\n');

  print('*' * 50);
}

// 流程控制语句 (https://dart.cn/samples#control-flow-statements)
void controlFlowStatements() {
  print('\n流程控制语句测试:');
  var year = 2014;
  if (year >= 2001) {
    // if else if 判断
    print('21st century');
  } else if (year >= 1901) {
    print('20th century');
  }

  // 循环输出
  var flybyObjects = ['Jupiter', 'Saturn', 'Uranus', 'Neptune'];
  for (final object in flybyObjects) {
    stdout.write(object + ' ');
  }
  print('');
  for (int month = 1; month <= 12; month++) {
    stdout.write(month);
    stdout.write(' ');
  }
  print('');
  while (year < 2016) {
    year += 1;
  }
  print(year);

  print('');
  print('*' * 50);
}

// 函数 (https://dart.cn/samples#functions)
int fibonacci(int n) {
  if (n == 0 || n == 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

bool is_hit(String line, String target) {
  return line.contains(target);
}

void functions() {
  print('\n函数测试:');

  var fib = fibonacci(10);
  print('fib(10) = $fib');

  var flybyObjects = ['hello', '输出含有kunkun的字符串', '58451', '好好学习，天天向上'];
  flybyObjects
      .where((name) => name.contains('kunkun'))
      .forEach(print); // 函数的胖箭头写法

  var hit_lines = flybyObjects.where((x) => is_hit(x, '5'));
  for (var one in hit_lines) {
    print('输出含有5的字符串 : $one');
  }

  print('');
  print('*' * 50);
}

// 注释 (https://dart.cn/samples#comments)
void comments() {
  print('\n注释测试:');

  // 比较常用的注释就是双斜杠

  /// 这是一个文档注释
  /// 文档注释用于为库、类以及类的成员添加注释
  /// 像IDE和dartdoc这样的工作可以专门处理文档注释

  /*也可以像这样使用单斜杠和星号的注释方式*/

  print('comments prints nothing');

  print('');
  print('*' * 50);
}

// 导入 (https://dart.cn/samples#imports)
void imports() {
  print('\n导入测试:');

  var mypi = pi;
  print('pi = $mypi');

  var x = pi / 4;
  var y = sin(x);
  print('sin(pi/4) = $y');

  print('');
  print('*' * 50);
}

// 类 (https://dart.cn/samples#classes)
// 类的属性不赋初值会报错，因此可以用 late 或者？来修饰
class Spacecraft {
  String name;
  DateTime? launchDate;
  int? get launchYear => launchDate?.year;
  Spacecraft(this.name, this.launchDate) {} // dart构造参数的一种写法，高效简洁
  Spacecraft.unlaunched(String name) : this(name, null);
  void describe() {
    print('Spacecraft: $name');
    var launchDate = this.launchDate;
    if (launchDate != null) {
      int years = DateTime.now().difference(launchDate).inDays ~/ 365;
      print('Launched: $launchYear ($years years ago)');
    } else {
      print('Unlaunched！');
    }
  }
}

void classes() {
  print('\n类测试:');
  var voyager1 = Spacecraft('Voyager I', DateTime(2002, 8, 17));
  var voyager2 = Spacecraft.unlaunched('Voyager III');
  voyager1.describe();
  voyager2.describe();
  print('');
  print('*' * 50);
}

// 扩展类（继承） (https://dart.cn/samples#inheritance)
class Orbiter extends Spacecraft {
  double altitude;
  Orbiter(String name, DateTime launchDate, this.altitude)
      : super(name, launchDate); // 构造方法继承父类

  @override
  void describe() {
    // 重写了describe方法，其实就是在原来的describe加了一条输出信息
    super.describe();
    print('altitude is $altitude km');
  }
}

void inheritance() {
  print('\n继承测试:');

  var obt = Orbiter('天宫号', DateTime(2021, 4, 29), 389.2);
  obt.describe();

  print('');
  print('*' * 50);
}

// Mixins (https://dart.cn/samples#mixins)
// 可以增加代码的复用性，用关键词with
mixin Piloted {
  int astronauts = 1;

  void describeCrew() {
    print('Number of astronauts: $astronauts');
  }
}

class PilotedCraft extends Spacecraft with Piloted {
  PilotedCraft(String name, DateTime launchDate) : super(name, launchDate);
}

void mixins() {
  print('\nmixins测试:');

  var plt = PilotedCraft('神舟1号', DateTime(1999, 11, 20));
  plt.describe();
  plt.describeCrew();

  print('');
  print('*' * 50);
}

// 接口和抽象类 (https://dart.cn/samples#interfaces-and-abstract-classes)
// Dart 没有 interface 关键字。所有的类都隐式定义了一个接口。因此，任意类都可以作为接口被实现。
class MockSpaceship implements Spacecraft {
  @override
  DateTime? launchDate;

  @override
  String name;

  MockSpaceship(this.name, this.launchDate);

  @override
  void describe() {
    print('Mock Spacecraft: $name');
  }

  @override
  int? get launchYear => launchDate?.year;
}

void interface_and_abstract_classes() {
  print('\n接口和抽象类测试:');

  var mock = MockSpaceship('测试飞行器', null);
  mock.describe();

  print('');
  print('*' * 50);
}

// 异步 (https://dart.cn/samples#async)
// 使用 async 和 await 关键字可以让你避免回调
Future<void> the_async() async {
  print('\n异步测试:');
  const seconds = Duration(seconds: 1);
  Future<void> printWithDelay1(String message) async {
    await Future.delayed(seconds);
    print(message);
  }

  printWithDelay1('过了1秒钟. 1');
  print('done 1.');

  Future<void> printWithDelay2(String message) {
    return Future.delayed(seconds).then((_) {
      print(message);
    });
  }

  printWithDelay2('过了1秒钟. 2');
  print('done 2.');

  Future<void> createDescriptions(Iterable<String> objects) async {
    for (final object in objects) {
      try {
        var file = File('$object.txt');
        if (await file.exists()) {
          var modified = await file.lastModified();
          print(
              'File for $object already exists. It was modified on $modified.');
          continue;
        }
        await file.create();
        await file.writeAsString('Start Describing $object in this file.');
        print('File for $object created.');
      } on IOException catch (e) {
        print('Cannot create description for $object: $e');
      }
    }
  }

  var the_objects = ['飞机', '火箭', '铲土车'];
  createDescriptions(the_objects);

  await Future.delayed(Duration(seconds: 5));

  print('');
  print('*' * 50);
}

// 异常 (https://dart.cn/samples#exceptions)
Future<void> show_descriptions(flybyObjects) async {
  try {
    for (final object in flybyObjects) {
      var description = await File('$object.txt').readAsString();
      print(description);
    }
  } on IOException catch (ex) {
    print('Could not describe object: $ex');
  } finally {
    flybyObjects.clear();
  }
}

void exceptions() {
  print('\n异常测试:');
  var flybyObjects = ['飞机', '火箭', '铲土车', '手机'];
  show_descriptions(flybyObjects);
}

Future<void> main(List<String> args) async {
  // 变量
  variables();

  // 流程控制语句
  controlFlowStatements();

  // 函数
  functions();

  // 注释
  comments();

  // 导入
  imports();

  // 类
  classes();

  // 扩展类(继承)
  inheritance();

  // Mixins
  mixins();

  // 接口和抽象类
  interface_and_abstract_classes();

// 异步
  await the_async();

  // 异常
  exceptions();
}
