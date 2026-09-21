// Simple course roster app
void printWelcome(String appName) {
  print('=== $appName ===');
}

// Build a short course code from the title
String generateCode(String title) =>
    title.substring(0, 2).toUpperCase() + '101';

void main(List<String> args) {
  printWelcome('Course Roster Manager');

  const int maxCapacity = 4;
  final DateTime createdAt = DateTime.now();

  String courseTitle = args.isNotEmpty
      ? args[0]
      : 'CS201: Mobile App Development';

  int capacity = maxCapacity;
  double creditHours = 3.0;
  bool isOpen = true;
  List<String> enrolledStudents = ['Aiden', 'Maria', 'Jamal'];
  Set<String> waitlist = {'Priya', 'Noah'};
  Map<String, int> attendanceCount = {'Aiden': 3, 'Maria': 4, 'Jamal': 2};

  print(
    '$courseTitle | Capacity: $capacity | Enrolled: ${enrolledStudents.length}',
  );

  // Instructor email may be missing
  String? instructorEmail;

  print(instructorEmail ?? 'TBA');

  // Generate a course enrollment code
  late String enrollmentCode;
  enrollmentCode = generateCode(courseTitle);
  print('Enrollment code: $enrollmentCode');

  print(instructorEmail?.length);

  String rawNames = ' Aiden , maria ,JAMAL , Priya ';
  List<String> cleanNames = [];
  for (var name in rawNames.split(',')) {
    cleanNames.add(name.trim());
  }

  String courseDescription =
      '''
Course Details:
- Title: $courseTitle
- Credit Hours: $creditHours
- Created At: $createdAt
''';

  print('Seats left: ${capacity - enrolledStudents.length}');

  int fullGroups = enrolledStudents.length ~/ 3;
  int leftover = enrolledStudents.length % 3;
  print('Full groups of 3: $fullGroups, leftover: $leftover');

  Object formInput = 'twenty-two';
  if (formInput is String) {
    print('This is text!');
  }
  if (formInput is! int) {
  }

  var report = StringBuffer()
    ..write('Report: $courseTitle')
    ..write(' | Cap: $capacity')
    ..write(' | Roster: ${enrolledStudents.length}');
  print(report.toString());

  List<String>? extraNotes;
  extraNotes?..add('Room change pending');
  print('Extra notes: $extraNotes');

  int? bonusSeats;
  bonusSeats ??= 0;
  print('Bonus seats: $bonusSeats');

  if (isOpen && enrolledStudents.length < capacity) {
    print("You're in! Welcome aboard.");
  } else {
    print('Enrollment closed or course is at full capacity.');
  }

  int enrollmentStatusCode = 200;
  switch (enrollmentStatusCode) {
    case 200:
      print('Enrolled');
      break;
    case 404:
      print('Course not found');
      break;
    default:
      print('Unknown error');
      break;
  }

  String statusTag = isOpen ? 'OPEN' : 'FULL';
  print(statusTag);

  for (var student in enrolledStudents) {
    print(student);
  }

  attendanceCount.forEach((student, count) {
    print('$student: $count');
  });

  List<String> announcements = [
    'Welcome to $courseTitle',
    if (!isOpen) 'Course is FULL — waitlist open',
    for (var student in waitlist)
      'Reminder: $student, please confirm attendance',
  ];

  for (var announcement in announcements) {
    print(announcement);
  }

  Set<String> secondCourseWaitlist = {'Liam', 'Noah', 'Zoe'};
  Set<String> combinedWaitlist = waitlist.union(secondCourseWaitlist);

  // Basic sanity checks
  assert(cleanNames.isNotEmpty);
  assert(courseDescription.isNotEmpty);
  assert(combinedWaitlist.isNotEmpty);
}
