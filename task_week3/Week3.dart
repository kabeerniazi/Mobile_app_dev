// Week3.dart - Library Desk Assistant
// Name: Muhammad Kabeer Khan reg.no: 04072313029

final List<Map<String, dynamic>> books = [
  {'title': 'Dart in Action', 'author': 'Ada', 'year': 2021, 'copies': 3, 'tags': ['dart', 'programming']},
  {'title': 'Flutter Basics', 'author': 'Sam', 'year': 2023, 'copies': 0, 'tags': ['flutter', 'mobile']},
  {'title': 'Clean Code', 'author': 'Martin', 'year': 2008, 'copies': 2, 'tags': ['programming', 'design']},
  {'title': 'Algorithms', 'author': 'Knuth', 'year': 1968, 'copies': 1, 'tags': ['programming', 'math']},
  {'title': 'UI Design', 'author': 'Nora', 'year': 2019, 'copies': 4, 'tags': ['design', 'mobile']},
];

// --- Top-Level Functions & Classes ---

// Part 1
double lateFee(int daysLate, double ratePerDay) => daysLate * ratePerDay;

String formatTitle(String title, [String? author]) => author == null ? title : '$title by$author';

Map<String, dynamic> makeBook({required String title, required String author, int year = 2024, int copies = 1}) {
  return {'title': title, 'author': author, 'year': year, 'copies': copies};
}

bool isClassic(int year) => year < 2000;

// Part 2
List<String> transformAll(List<String> items, String Function(String) fn) => items.map(fn).toList();

int Function() makeCounter() {
  int count = 0;
  return () {
    count++;
    return count;
  };
}

double Function(int) makeFeeCalculator(double rate) => (int days) => days * rate;

int sumDigits(int n) {
  if (n < 10) return n;
  return (n % 10) + sumDigits(n ~/ 10);
}

// Part 3
Map<String, int> buildStock() {
  return {
    for (var b in books) b['title'] as String: b['copies'] as int
  };
}

// Part 4
class Box<T> {
  T value;
  Box(this.value);
}

T firstOr<T>(List<T> items, T fallback) => items.isNotEmpty ? items.first : fallback;

class Pair<A, B> {
  A first;
  B second;
  Pair(this.first, this.second);

  @override
  String toString() => '($first,$second)';
}

// Part 5
class BookNotFoundException implements Exception {
  final String title;
  BookNotFoundException(this.title);
  @override
  String toString() => 'Not found: "$title"';
}

class BookNotAvailableException implements Exception {
  final String title;
  BookNotAvailableException(this.title);
  @override
  String toString() => 'Sorry: "$title" has no copies left';
}

void checkOut(Map<String, int> stock, String title) {
  if (!stock.containsKey(title)) throw BookNotFoundException(title);
  if (stock[title]! <= 0) throw BookNotAvailableException(title);
  stock[title] = stock[title]! - 1;
}

Map<String, dynamic> findBook(String title) {
  return books.firstWhere((b) => b['title'] == title);
}

// Part 6
Future<String> fetchBookOfTheDay() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Dart in Action';
}

Future<String> fetchBroken() async {
  await Future.delayed(Duration(milliseconds: 500));
  throw Exception('Server down');
}

// --- Bonus Functions ---
// B1
Map<String, List<String>> groupBooksByTag() {
  Map<String, List<String>> grouped = {};
  for (var b in books) {
    for (var tag in b['tags'] as List<String>) {
      grouped.putIfAbsent(tag, () => []).add(b['title'] as String);
    }
  }
  return grouped;
}

// B2
List<T> filterBy<T>(List<T> items, bool Function(T) test) {
  return items.where(test).toList();
}


// --- Main & Part Runners ---

void main() async {
  part1();
  part2();
  part3();
  part4();
  part5();
  await part6();
}

void part1() {
  print('--- Part 1 ---');
  print('Late fee: ${lateFee(5, 0.5)}');
  print(formatTitle('Dart in Action'));
  print(formatTitle('Dart in Action', 'Ada'));
  print(makeBook(title: 'Clean Code', author: 'Martin'));
  print(makeBook(title: 'Algorithms', author: 'Knuth', year: 1968));
  print(isClassic(1968));
  print(isClassic(2021));
}

void part2() {
  print('--- Part 2 ---');
  print(transformAll(['Dart in Action', 'Clean Code'], (s) { return s.toUpperCase(); }));
  print(transformAll(['Dart in Action', 'Clean Code'], (s) => '$s!'));
  
  var desk1 = makeCounter();
  var desk2 = makeCounter();
  print(desk1());
  print(desk1());
  print(desk1());
  print(desk2());
  
  var studentFee = makeFeeCalculator(0.25);
  var staffFee = makeFeeCalculator(0.10);
  print('Student fee: ${studentFee(4)}');
  print('Staff fee: ${staffFee(4)}');
  
  print('Sum of digits: ${sumDigits(125)}'); // Using 125 to get 8 as requested
}

void part3() {
  print('--- Part 3 ---');
  var titles = books.map((b) => b['title'] as String).toList();
  print('Titles: $titles');
  
  var available = books.where((b) => (b['copies'] as int) > 0).map((b) => b['title'] as String).toList();
  print('Available: $available');
  
  var totalCopies = books.fold(0, (int sum, b) => sum + (b['copies'] as int));
  print('Total copies: $totalCopies');
  
  var oldestYear = books.map((b) => b['year'] as int).reduce((a, b) => a < b ? a : b);
  print('Oldest year: $oldestYear');
  
  var sortedBooks = [...books];
  sortedBooks.sort((a, b) => (a['year'] as int).compareTo(b['year'] as int));
  print('By year: ${sortedBooks.map((b) => b['title'] as String).toList()}');
  
  var stock = buildStock();
  print('Stock: $stock');
  
  stock.forEach((title, count) {
    if (count == 0) {
      print('Out of stock: $title');
    }
  });
  
  print('Copies of Unknown: ${stock['Unknown'] ?? 0}');
  
  var tags = { for (var b in books) ...(b['tags'] as List<String>) };
  print('All tags: $tags');
  
  var a = {'Dart in Action', 'Clean Code', 'Flutter Basics'};
  var b = {'Clean Code', 'Flutter Basics', 'Algorithms'};
  print('Union: ${a.union(b)}');
  print('Common: ${a.intersection(b)}');
  print('Only in A: ${a.difference(b)}');
}

void part4() {
  print('--- Part 4 ---');
  var intBox = Box<int>(5);
  var stringBox = Box<String>('dart');
  print('Box<int>: ${intBox.value}');
  print('Box<String>: ${stringBox.value}');
  // intBox.value = 'hello'; // Compile error: A value of type 'String' can't be assigned to a variable of type 'int'.
  
  print(firstOr(['Dart in Action', 'Clean Code'], 'none'));
  print(firstOr<String>([], 'z'));
  
  print(Pair('Dart in Action', 3));
}

void part5() {
  print('--- Part 5 ---');
  var stock = buildStock();
  var requests = ['Dart in Action', 'Flutter Basics', 'Unknown Book'];
  
  for (var title in requests) {
    try {
      checkOut(stock, title);
      print('Checked out: $title');
    } on BookNotFoundException catch (e) {
      print(e);
    } on BookNotAvailableException catch (e) {
      print(e);
    } catch (e) {
      print('An unexpected error occurred: $e');
    } finally {
      print('Transaction logged.');
    }
  }
  print('Copies left of Dart in Action: ${stock['Dart in Action']}');
  
  try {
    findBook('Missing');
  } on StateError {
    print('Search failed: no such book');
  }
}

Future<void> part6() async {
  print('--- Part 6 ---');
  print('Fetching...');
  var book = await fetchBookOfTheDay();
  print('Book of the day: $book');
  
  try {
    await fetchBroken();
  } catch (e) {
    print('Fetch failed: $e');
  }
}

/* --- Reflection Questions ---
1. When would you choose fold over reduce?
we use `fold` when the collection might be empty (it allows providing a safe starting value) or when the result type differs from the collection's item type. `reduce` throws an error on an empty list and requires the input and output to be the same type.

2. What does it mean that a closure "captures" a variable? Which variable was captured in makeCounter?
Capturing a variable means an inner function retains access to a variable from its outer scope even after the outer function has finished executing. In `makeCounter`, the variable `count` was captured.

3. Why must on BookNotAvailableException come before a general catch (e)?
Dart processes `catch` blocks top-to-bottom. If a general `catch (e)` (or catching a broader class like Exception) comes first, it will intercept all errors, meaning the more specific `on BookNotAvailableException` block will never execute.

4. Why does forgetting await still compile, but give the wrong result?
Because an async function immediately returns an object of type `Future<T>`. Without `await`, Dart assigns the uncompleted Future object itself to the variable instead of waiting for the actual `T` value to resolve, which is perfectly valid structurally but illogical for your data flow.
*/