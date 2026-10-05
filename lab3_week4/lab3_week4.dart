// lab3.dart
// Name: Muhammad Kabeer Khan
// Roll no: 04072313029

const String rollNo = '04072313029';

final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10;  // units digit

const List<String> menu = [
  'Chai', 'Latte', 'Mocha', 'Samosa', 'Brownie',
  'Sandwich', 'Cold Coffee', 'Fries', 'Pakora', 'Zinger Wrap',
];

int priceOf(int i) => 100 + 7 * i + 3 * t; // price of menu[i], in rupees
final int priceFloor = 60 + 5 * t;
final int taxPercent = 5 + t;
final int bigOrderLimit = 450 + 20 * t;
final int balanceCap = 600 + 20 * t;
final int couponPercent = 5 + t + u;

// =====

class Dish {
  late String name;
  late int price;
}

void step1() {
  print('--- Step 1 ---');
  Dish item1 = Dish()
    ..name = menu[u]
    ..price = priceOf(u);

  Dish item2 = Dish()
    ..name = menu[(u + 1) % 10]
    ..price = priceOf((u + 1) % 10);
  
  item2.price = item2.price - u;

  print('Step 1: ${item1.name} Rs ${item1.price}');
  print('Step 1: ${item2.name} Rs ${item2.price}');
}

class MenuItem {
  String name;
  int price;
  
  // the lines of code below belong to task 3
  
  MenuItem.free(this.name) : price = 0;

  MenuItem.fromString(String text)
      : name = text.split(':')[0],
        price = int.parse(text.split(':')[1]);
  
  // the lines of code above belong to task 3
  
  //the lines of code below belong to task 8
  
  @override
  String toString() => '$name (Rs $price)';
  
  // the lines of code above belong to ts 8
  
  MenuItem(this.name, this.price) {
    if (this.price < priceFloor) {
      this.price = priceFloor;
    }
  }
}

void step2() {
  print('--- Step 2 ---');
  var a = MenuItem(menu[u], priceOf(u));
  var b = MenuItem('Test Special', 15 * u);

  print('Step 2: ${a.name} Rs${a.price}');
  print('Step 2: Test Special Rs ${b.price}');
  
  // Think: Why could price not be declared final in this version of the class?
  // Answer: Because we modify `this.price` inside the constructor body to enforce the priceFloor.
  
}

void step3() {
  print('--- Step 3 ---');
  var freebie = MenuItem.free('Water');
  int i = (u + 2) % 10;
  var parsed = MenuItem.fromString('${menu[i]}:${priceOf(i)}');

  print('Step 3: ${freebie.name} Rs${freebie.price}');
  print('Step 3: ${parsed.name} Rs${parsed.price}');
  print('Step 3: floor=$priceFloor, free price=${freebie.price}');
  
  // Think: The floor is, say, 80 but free() produced 0. Why did the floor logic not run?
  // Answer: The floor logic is in the body of the main constructor. The named constructor `MenuItem.free` does not redirect to the main constructor, bypassing that logic.
}

class OrderLog {
  static OrderLog? _instance;
  final List<String> entries = [];

  OrderLog._internal();

  factory OrderLog() => _instance ??= OrderLog._internal();

  void add(String msg) => entries.add(msg);
}

void step4() {
  print('--- Step 4 ---');
  var log1 = OrderLog();
  var log2 = OrderLog();

  for (int i = 1; i <= (u + 2); i++) {
    String msg = 'order #${100 * t + i}';
    if (i % 2 != 0) {
      log1.add(msg);
    } else {
      log2.add(msg);
    }
  }

  print('Step 4: same object? ${identical(log1, log2)}');
  print('Step 4: entries = ${log1.entries.length}');
  print('Step 4: last = ${log2.entries.last}');
  
  // Think: Why do _instance and _internal start with an underscore? What could go wrong if they did not?
  // Answer: It makes them private to this file. If public, code could bypass the factory and create new instances directly using `OrderLog._internal()`, breaking the singleton pattern.
}

class OrderLine {
  final MenuItem item;
  final int qty;
  final int total;
  final int tax;

  // task 6 code below 
  int get grand => total + tax;
  bool get isBigOrder => grand > bigOrderLimit;
  String get label => '${item.name} x$qty';
  //task 6 code above
  
  OrderLine(this.item, this.qty)
      : total = item.price * qty,
        tax = (item.price * qty * taxPercent) ~/ 100,
        assert(qty > 0, 'qty must be positive');
}

OrderLine mainOrder() {
  return OrderLine(MenuItem(menu[u], priceOf(u)), 2 + (t + u) % 5);
}

void step5() {
  print('--- Step 5 ---');
  var line = mainOrder();
  print('Step 5: ${line.item.name} x${line.qty}');
  print('Step 5: total=${line.total} tax=${line.tax}');

  try {
    OrderLine(line.item, 0);
    print('Step 5: assert did NOT fire');
  } on AssertionError {
    print('Step 5: assert fired');
  }

  // Think: Why can an initializer list not read another field of the same object?
  // Answer: During the initializer list execution, the object (`this`) has not been fully constructed yet, so its properties cannot be accessed.
}

void step6() {
  print('--- Step 6 ---');
  var line = mainOrder();
  print('Step 6: grand=${line.grand}');
  print('Step 6: big order? ${line.isBigOrder} (limit$bigOrderLimit)');
  print('Step 6: label=${line.label}');

  // Think: Why does line.grand = 5; fail? What would you have to add to make it legal?
  // Answer: `grand` is defined only as a getter, meaning it is read-only. To make it assignable, you would need to define a setter.
}

class StudentCard {
  final String owner;
  int _balance;

  StudentCard(this.owner) : _balance = 0;

  int get balance => _balance;

  set balance(int v) {
    if (v < 0) {
      _balance = 0;
    } else if (v > balanceCap) {
      _balance = balanceCap;
    } else {
      _balance = v;
    }
  }
}

void step7() {
  print('--- Step 7 ---');
  var card = StudentCard('S$seed');
  
  card.balance = seed * 10 + 50;
  print('Step 7: topped up -> ${card.balance}');
  
  card.balance = -seed - 1;
  print('Step 7: bad value -> ${card.balance}');
  
  card.balance = balanceCap - u;
  print('Step 7: reset -> ${card.balance}');
  
  card.balance = card.balance - mainOrder().grand;
  print('Step 7: paid order -> ${card.balance}');

  // Think: The setter silently clamps a bad value. What is one other thing a setter could do with an invalid value?
  // Answer: It could throw an exception (like `ArgumentError`) to explicitly alert the caller about the invalid input.
}

//task 8
List<MenuItem> buildMenu() {
  return [
    for (var k = 0; k <= 3; k++)
      MenuItem.fromString(
          '${menu[(u + 3 * k) % 10]}:${priceOf((u + 3 * k) % 10)}')
  ];
}

void step8() {
  print('--- Step 8 ---');
  var currentMenu = buildMenu();
  var priciest = currentMenu.reduce((curr, next) => curr.price > next.price ? curr : next);
  var sum = currentMenu.fold<int>(0, (prev, item) => prev + item.price);

  print('Step 8: menu = $currentMenu');
  print('Step 8: priciest = ${priciest.name}');
  print('Step 8: sum = $sum');
}

// task 9
List<OrderLine> buildReceipt() {
  var items = buildMenu().take(3).toList();
  return [
    for (var k = 0; k < 3; k++) OrderLine(items[k], 1 + (t + k) % 4)
  ];
}
void step9() {
  print('--- Step 9 ---');
  var receiptLines = buildReceipt();
  int totalGrand = 0;

  for (var line in receiptLines) {
    print('Step 9: ${line.label} = ${line.grand}');
    totalGrand += line.grand;
    OrderLog().add('receipt: ${line.label}');
  }

  print('Step 9: receipt total = $totalGrand');
  print('Step 9: log size = ${OrderLog().entries.length}');
}

class Coupon {
  static final Map<String, Coupon> _cache = {};
  final String code;
  final int percent;
  final int minSpend;

  Coupon(this.code, this.percent)
      : minSpend = percent * 70,
        assert(percent >= 1 && percent <= 50);

  factory Coupon.fromCode(String code) {
    return _cache.putIfAbsent(code, () => Coupon(code, couponPercent));
  }

  int discountOn(int amount) {
    if (amount >= minSpend) return amount * percent ~/ 100;
    return 0;
  }
}

void step10() {
  print('--- Step 10 ---');
  String code = 'CAFE${seed.toString().padLeft(2, '0')}';
  var c1 = Coupon.fromCode(code);
  var c2 = Coupon.fromCode(code);

  int receiptAmount = buildReceipt().fold<int>(0, (sum, line) => sum + line.grand);
  int discount = c1.discountOn(receiptAmount);
  int payable = receiptAmount - discount;

  print('Step 10: ${c1.code} gives ${c1.percent}% off, min spend ${c1.minSpend}');
  print('Step 10: cached? ${identical(c1, c2)}');
  print('Step 10: receipt $receiptAmount, discount $discount, payable $payable');
}

void main() {
  print('Seed: $seed (t=$t, u=$u)');
  step1();
  step2();
  step3();
  step4();
  step5();
  step6();
  step7();
  step8();
  step9();
  step10();
}

/* 
Wrap-up Reflection Questions:
Q1. Animal(this.name, this.type); and the verbose constructor give the same result. What does the shorthand save you?
Answer: It saves you from writing repetitive boilerplate code to assign parameters to fields in the constructor body.

Q2. When would you choose a named constructor, and when a factory constructor?
Answer: Choose a named constructor to provide alternative ways to initialize an object's state (e.g., parsing from a string). Choose a factory constructor when you need control over what instance is returned (e.g., returning a cached instance or a subtype) rather than always creating a brand new object.

Q3. What is the difference between assigning a field in a constructor body and assigning it in an initializer list?
Answer: The initializer list executes before the object is fully constructed, allowing you to assign values to `final` fields. The constructor body runs after the object is initialized, so it cannot assign values to `final` variables.

Q4. Give one reason to use a getter instead of storing the value in a field, and one reason to use a setter instead of a public field.
Answer: Use a getter to dynamically compute a value based on other fields without storing duplicate data. Use a setter to protect data by running validation or transformation logic before assignment.
*/

// void step1() {}
// void step2() {}
// void step3() {}
// void step4() {}
// void step5() {}
// void step6() {}
// void step7() {}
// void step8() {}
// void step9() {}
//void step10() {}