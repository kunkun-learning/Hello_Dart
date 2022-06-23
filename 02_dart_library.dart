// 数字、集合、字符串(https://dart.cn/guides/libraries/library-tour#dartcore---numbers-collections-strings-and-more)
import 'dart:collection';
import 'dart:math';
import 'dart:convert';

// 测试dart核心库中数字、集合、字符串的功能
void numCollectionString() {
  print('#' * 45);
  print("Dart核心库中数字、集合、字符串测试");

  // 将字符串转换为数值
  assert(int.parse('42') == 42);
  assert(int.parse('0x42') == 66);
  assert(double.parse('0.50') == 0.5);

  // 将数值转换为字符串
  assert(42.toString() == '42');
  assert(123.456.toString() == '123.456');

  // 四舍五入
  assert(123.456.toStringAsFixed(2) == '123.46');

  // 科学计数法间的转换
  assert(123.456.toStringAsPrecision(2) == '1.2e+2');
  assert(double.parse('1.2e+2') == 120.0);

  // 字符串常用方法
  String sample = 'Just do it';
  assert(sample.contains('it'));
  assert(sample.startsWith('Just'));
  assert(sample.endsWith('it'));
  assert(sample.indexOf('do') == 5);
  assert(sample.substring(0, 3) == 'Just');

  var parts = sample.split(' '); // split参数留空会将每个字符分开
  assert(parts.length == 3);
  assert(parts[0] == 'Just');

  assert(sample[0] == 'J');

  // 字符串的codeUnits属性
  var codeUnitList = sample.codeUnits.toList();
  assert(codeUnitList[0] == 78);

  assert('web apps'.toUpperCase() == 'WEB APPS');
  assert('WEB APPS'.toLowerCase() == 'web apps');
  assert('  hello   '.trim() == 'hello');

  // 判断是否为空字符串
  assert(''.isEmpty);
  assert('  '.isNotEmpty);

  var greetingTemplate = 'Hello, NAME!';
  var greeting = greetingTemplate.replaceAll(RegExp('NAME'), 'George');

  assert(greeting != greetingTemplate);

  var sb = StringBuffer();
  sb
    ..write('Use a StringBuffer for ')
    ..writeAll(['efficient', 'string', 'creation'], ' ')
    ..write('.');

  var fullString = sb.toString();
  assert(fullString == 'Use a StringBuffer for efficient string creation.');

  // 正则测试
  // 匹配一个或多个数字
  var numbersRe = RegExp(r'\d+');
  var allCharacters = 'llamas live fifteen to twenty years';
  var someDigits = 'llamas live 15 to 20 years';

  assert(!allCharacters.contains(numbersRe));
  assert(someDigits.contains(numbersRe));
}

// 测试dart中列表的操作
void the_lists() {
  var grains = <String>[];
  assert(grains.isEmpty);

  var fruits = ['apples', 'oranges'];
  fruits.add('pineapples');
  fruits.addAll(['grapes', 'bananas']);

  fruits.insert(0, 'peach'); // 插在第一个位置上
  assert(fruits.length == 6);

  var appleIndex = fruits.indexOf('apples');
  fruits.removeAt(appleIndex);
  assert(fruits.length == 5);
  fruits.clear();
  assert(fruits.isEmpty);

  var vegetables = List.filled(99, 'broccoli');
  assert(vegetables.every((element) => element == 'broccoli'));

  fruits = ['bananas', 'apples', 'oranges'];
  fruits.sort((a, b) => a.compareTo(b)); // 排序
  assert(fruits[0] == 'apples');
  fruits = <String>[];
  fruits.add('apples');
  var fruit = fruits[0];
  assert(fruit is String);
}

void the_sets() {
  var ingredients = <String>{};
  ingredients.addAll(['gold', 'titanium', 'xenon']);
  assert(ingredients.length == 3);

  // 在集合中添加已有元素
  ingredients.add('gold');
  assert(ingredients.length == 3);

  ingredients.remove('gold');
  assert(ingredients.length == 2);

  // 使用Set的from构造函数
  var atomicNumbers = Set.from([1, 2, 3]);
  assert(atomicNumbers.length == 3);

  ingredients.clear();
  ingredients.addAll(['gold', 'titanium', 'xenon']);
  assert(ingredients.contains('titanium'));
  assert(ingredients.containsAll(['titanium', 'xenon']));

  ingredients.clear();
  ingredients.addAll(['gold', 'titanium', 'xenon']);

  // 集合的一些基本运算
  var nobelGases = Set.from(['xenon', 'argon']);
  var intersection = ingredients.intersection(nobelGases);
  assert(intersection.length == 1);
  assert(intersection.contains('xenon'));
}

void the_maps() {
  var hawaiianBeaches = {
    'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
    'Big Island': ['Wailea Bay', 'Pololu Beach'],
    'Kauai': ['Hanalei', 'Poipu']
  };

  var searchTerms = Map();
  var nobleGases = Map<int, String>(); // 规定键的类型
  nobleGases = {54: 'xenon'};
  assert(nobleGases[54] == 'xenon');
  assert(nobleGases.containsKey(54));

  // 删除Map中的键值对
  nobleGases.remove(54);
  assert(!nobleGases.containsKey(54));

  // 获得Map的所有键的Iterator
  var keys = hawaiianBeaches.keys;
  assert(keys.length == 3);
  assert(Set.from(keys).contains('Oahu'));

  // 获得Map的所有值的Iterator
  var values = hawaiianBeaches.values;
  assert(values.length == 3);
  assert(values.any((element) => element.contains('Kailua')));

  hawaiianBeaches = {
    'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
    'Big Island': ['Wailea Bay', 'Pololu Beach'],
    'Kauai': ['Hanalei', 'Poipu']
  };
  assert(hawaiianBeaches.containsKey('Oahu'));
  assert(!hawaiianBeaches.containsKey('Florida'));

  var teamAssignments = <String, String>{};
  String pickToughestKid() {
    return "pickToughestKid";
  }

  teamAssignments.putIfAbsent('Catcher', () => pickToughestKid());
  assert(teamAssignments['Catcher'] != null);
}

void public_methods() {
  var coffees = <String>[];
  var teas = ['green', 'black', 'chamomile', 'earl grey'];
  assert(coffees.isEmpty);
  assert(teas.isNotEmpty);
  teas.forEach((element) => print('I drink $teas'));

  var hawaiianBeaches = {
    'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
    'Big Island': ['Wailea Bay', 'Pololu Beach'],
    'Kauai': ['Hanalei', 'Poipu']
  };

  hawaiianBeaches.forEach((key, value) {
    print("I want to visit $key and swim at $value");
  });

  teas = ['green', 'black', 'chamomile', 'earl grey'];
  var loudTeas = teas.map((tea) => tea.toUpperCase());
  loudTeas.forEach(print);
  var loadTeas_str = loudTeas.toList();
  print(loadTeas_str);

  // 用匿名函数创建新函数
  bool isDecaffeinated(String teaName) => teaName == 'chamomile';

  // 查询
  var decaffeinatedTeas = teas.where((tea) => isDecaffeinated(tea));
  assert(teas.any(isDecaffeinated));
  assert(!teas.every(isDecaffeinated));
}

void collections() {
  print('#' * 45);
  print('集合测试：');
  the_lists();
  the_sets();
  the_maps();
  public_methods();
}

void uri_test() {
  print('#' * 45);
  print('URI测试：');
  // 常用功能
  var uri = 'https://www.optgeo.top/?title=你好';
  print('原始URI：$uri');

  // 将除了/:&#外的字符都进行编码，以生成一个合法可用的URI
  var encoded = Uri.encodeFull(uri);
  print('encodeFull得到的：$encoded');
  assert(encoded == 'https://www.optgeo.top/?title=%E4%BD%A0%E5%A5%BD');

  // 反向操作解码
  var decoded = Uri.decodeFull(encoded);
  assert(decoded == 'https://www.optgeo.top/?title=你好');

  // 将所有字符都编码
  encoded = Uri.encodeComponent(uri);
  print("encodeComponent得到的：$encoded");
  assert(encoded ==
      'https%3A%2F%2Fwww.optgeo.top%2F%3Ftitle%3D%E4%BD%A0%E5%A5%BD');
  decoded = Uri.decodeComponent(encoded);
  assert(decoded == 'https://www.optgeo.top/?title=你好');

  // 解析网址并获取各个部分的内容
  var uri_parse = Uri.parse(uri);
  assert(uri_parse.scheme == 'https');
  assert(uri_parse.host == 'www.optgeo.top');
  assert(uri_parse.path == '/');

  // 通过各个部分的内容构造出URI
  var another_uri = Uri(
    scheme: 'https',
    host: 'www.optgeo.top',
    path: '/',
  );
  assert(another_uri.toString() == 'https://www.optgeo.top/');
}

void dates_and_times() {
  print('#' * 40);
  print('时间和日期测试');

  // 通过多种方式构建DateTime，若不是特别指定，默认构建的是LocalTime
  var now = DateTime.now();
  // 2000/1/1
  var y2k = DateTime(2000);
  // 2000/1/2
  y2k = DateTime(2000, 1, 2);
  // UTC 2000/1/1
  y2k = DateTime.utc(2000);
  // Unix时间戳构建
  y2k = DateTime.fromMicrosecondsSinceEpoch(946680000000, isUtc: true);
  y2k = DateTime.parse('2000-01-01T00:00:00Z');
  y2k = DateTime.utc(2000);
  assert(y2k.millisecondsSinceEpoch == 946684800000);
  // unix时间戳原点
  var unixEpoch = DateTime.utc(1970);
  assert(unixEpoch.millisecondsSinceEpoch == 0);

  // 对DateTime的一些操作
  y2k = DateTime.utc(2000);

  // 加上1年
  var y2001 = y2k.add(const Duration(days: 366));
  assert(y2001.year == 2001);

  // 计算DateTime之间的时间差
  var duration = y2001.difference(y2k);
  assert(duration.inDays == 366);
}

// 工具类（https://dart.cn/guides/libraries/library-tour#utility-classes）
class Line implements Comparable<Line> {
  final int length;
  const Line(this.length);
  @override
  int compareTo(Line other) => length - other.length;
}

class Person {
  final String firstName, lastName;
  Person(this.firstName, this.lastName);
  @override
  int get hashCode => Object.hash(firstName, lastName);
  @override
  bool operator ==(Object other) =>
      other is Person &&
      firstName == other.firstName &&
      lastName == other.lastName;
}

class Process {
  int _uid;
  Process(this._uid);
  int get uid => _uid;
}

// 作为Processes的迭代器
class ProcessIterator implements Iterator<Process> {
  List<Process> list;
  int index = -1;
  ProcessIterator(this.list);
  @override
  Process get current => list[index];
  @override
  bool moveNext() => (++index) < list.length;
}

class Processes extends IterableBase<Process> {
  List<Process> process;
  Processes(this.process);
  @override
  Iterator<Process> get iterator => ProcessIterator(this.process);
}

void utility_test() {
  print('#' * 45);
  print('工具类测试：');
  // 实现了Comparable接口的类，用compareTo进行比较
  var short = Line(1);
  var long = Line(100);
  assert(short.compareTo(long) < 0);

  // 重写了hashCode的getter的类
  var p1 = Person('Bob', 'Smith');
  var p2 = Person('Bob', 'Smith');
  var p3 = 'not a person';
  assert(p1.hashCode == p2.hashCode);
  assert(p1 == p2);
  assert(p1 != p3);

  // 测试有Iterator的类
  var pr1 = Process(1);
  var pr2 = Process(2);
  Processes processes = Processes([pr1, pr2]);
  print('迭代器');
  for (Process p in processes) {
    print(p.uid);
  }
}

// 异常(https://dart.cn/guides/libraries/library-tour#exceptions)
class FooException implements Exception {
  final String? msg;
  const FooException([this.msg]);
  @override
  String toString() => msg ?? 'FooException';
}

void exception_test(bool t) {
  print('#' * 45);
  print('异常类测试');
  if (!t) {
    throw FooException('This is an exception msg');
  }
}

// 异步编程 (https://dart.cn/guides/libraries/library-tour#dartasync---asynchronous-programming)
Future<Function> findEntryPoint() async {
  await Future.delayed(Duration(seconds: 3));
  return print;
}

// 以args为参数执行exec函数
Future<int> runExecutable(exec, args) async {
  exec(args);
  return 0;
}

// 分析exit code，此处直接输出一下
Future<void> flushThenExit(code) async {
  print('exit with code $code');
}

// 使用then链式回调按顺序执行异步函数
void runUsingFuture() {
  findEntryPoint().then((entryPoint) {
    return runExecutable(entryPoint, "using then to callback.");
  }).then(flushThenExit);
}

// 使用await可以写出类似于同步的异步代码
Future<void> runUsingAsyncAwait() async {
  var entryPoint = await findEntryPoint();
  try {
    var exitCode = await runExecutable(entryPoint, 'using await to callback.');
    await flushThenExit(exitCode);
  } catch (e) {}
}

Future<void> throw_error_future(bool flag) async {
  if (!flag) {
    throw FooException('Exception in async function.');
  } else {
    print('No throwing Exception in async function.');
  }
}

// catch异步函数中抛出的异常
void catch_error(bool flag) {
  throw_error_future(flag).then((_) {}).catchError((e) {
    print(e);
  });
}

// 测试各种异步操作
void async_test() {
  print('#' * 45);
  print('异步Future测试：');
  runUsingFuture();
  runUsingAsyncAwait();
  catch_error(false);
}

// 数学和随机数
void math_and_random() {
  print('#' * 45);
  print('数学和随机数测试：');

  assert(cos(pi).round() == -1.0);

  // 度数和弧度的转换
  var degrees = 30;
  var radians = degrees * (pi / 180);
  var sinOf30degrees = sin(radians);

  // 一些基本的数学计算操作
  assert((sinOf30degrees - 0.5).abs() < 0.01);
  assert(max(1, 1000) == 1000);
  assert(min(1, -1000) == -1000);

  // 一些数学常量，有些基本的根号的无理数值也有
  print(e);
  print(pi);
  print(sqrt2);

  // 各类随机数的生成
  var random = Random();
  var value1 = random.nextDouble();
  print('nextDouble: $value1');
  var value2 = random.nextInt(10);
  print('nextInt: $value2');
  var value3 = random.nextBool();
  print('nextBool: $value3');
}

//编解码(https://dart.cn/guides/libraries/library-tour#dartconvert---decoding-and-encoding-json-utf-8-and-more)
void decodeJson() {
  // 用以测试解析的json
  var jsonString = '''
  [
    {"score": 40},
    {"score": 80}
  ]
  ''';
  var scores = jsonDecode(jsonString);

  // 会按照json的具体内容自动选择格式进行解析
  assert(scores is List);

  var firstScore = scores[0];
  assert(firstScore is Map);
  assert(firstScore['score'] == 40);
}

void encodeJson() {
  var scores = [
    {'score': 40},
    {'score': 80},
    {'score': 100, 'overtime': true, 'special_guest': null}
  ];

  // 自动解析成string
  var jsonText = jsonEncode(scores);
  assert(jsonText ==
      '[{"score":40},{"score":80},'
          '{"score":100,"overtime":true,"special_guest":null}]');
  print(jsonText);
}

// 测试json解析的功能
void jsonTest() {
  print('#' * 45);
  print('Json编码与解码测试：');
  decodeJson();
  encodeJson();
}

// utf8解析测试
void uft8Test() {
  print('#' * 40);
  print('uft8解析测试：');
  // 将utf8编码转换为字符串
  List<int> utf8Bytes = [
    0xc3,
    0x8e,
    0xc3,
    0xb1,
    0xc5,
    0xa3,
    0xc3,
    0xa9,
    0x72,
    0xc3,
    0xb1,
    0xc3,
    0xa5,
    0xc5,
    0xa3,
    0xc3,
    0xae,
    0xc3,
    0xb6,
    0xc3,
    0xb1,
    0xc3,
    0xa5,
    0xc4,
    0xbc,
    0xc3,
    0xae,
    0xc5,
    0xbe,
    0xc3,
    0xa5,
    0xc5,
    0xa3,
    0xc3,
    0xae,
    0xe1,
    0xbb,
    0x9d,
    0xc3,
    0xb1
  ];
  var funnyWord = utf8.decode(utf8Bytes);
  print(funnyWord);
  assert(funnyWord == 'Îñţérñåţîöñåļîžåţîờñ');

  // 将字符串转换为utf8编码
  List<int> encoded = utf8.encode('Îñţérñåţîöñåļîžåţîờñ');

  assert(encoded.length == utf8Bytes.length);
  for (int i = 0; i < encoded.length; i++) {
    assert(encoded[i] == utf8Bytes[i]);
  }
}

void main(List<String> args) {
  numCollectionString();
  collections();
  uri_test();
  dates_and_times();
  utility_test();
  exception_test(true);
  math_and_random();
  jsonTest();
  uft8Test();
  async_test();
}
