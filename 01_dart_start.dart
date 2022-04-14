// import 'package:test/test.dart';
// import 'path/to/my_other_file.dart';

// 变量 (https://dart.cn/samples#variables)
void variables() {
  var name = 'Voyager I';
  var year = 1977;
  var antennaDiameter = 3.7;
  var flybyObjects = ['Jupiter', 'Saturn', 'Uranus', 'Neptune'];
  var image = {
    'tags': ['saturn'],
    'url': '//path/to/saturn.jpg'
  };

  print(
      'name is $name, year is $year, antennaDiameter is $antennaDiameter, flybyObjects is $flybyObjects, image is $image');
}

// 流程控制语句 (https://dart.cn/samples#control-flow-statements)
void controlFlowStatements() {
  var year = 2014;
  if (year >= 2001) {
    print('21st century');
  } else if (year >= 1901) {
    print('20th century');
  }

  var flybyObjects = ['Jupiter', 'Saturn', 'Uranus', 'Neptune'];
  for (final object in flybyObjects) {
    print(object);
  }

  for (int month = 1; month <= 12; month++) {
    print(month);
  }

  while (year < 2016) {
    year += 1;
  }
  print(year);
}

// 函数 (https://dart.cn/samples#functions)
int fibonacci(int n) {
  if (n == 0 || n == 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

// 导入相关库，见开头

// 类

void main(List<String> args) {
  // 变量
  // variables();

  // 流程控制语句
  // controlFlowStatements();

  // 函数
  // var res = fibonacci(20);
  // print(res);

  // 注释hh

  // 导入,开头已经导入,这里测试一下math库中的函数
}
