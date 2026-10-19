// main.dart - Study Tracker lab
import 'dart:async';
import 'package:flutter/material.dart';

const String studentName = 'Muhammad Kabeer Khan';
const String rollNo = '04072313029'; // e.g. '21F-0347'

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit (2)
final int u = seed % 10; // units digit (9)

const List<String> courses = [
  'Mobile Dev',
  'Data Structures',
  'Operating Systems',
  'Databases',
  'Networks',
  'Software Eng',
  'AI',
  'Web Engineering',
  'Graphics',
  'Security',
];

final String course = courses[u]; // Security
final int startCount = 3 + u; // 12
final int stepSize = 1 + t % 4; // 3
final int maxCount = 20 + 2 * t; // 24
final int startSeconds = 5 + (t + u) % 6; // 10
final int bugStep = 1 + u % 4; // 2
// ===========================================================================

// Step 9 writes to this list from initState and dispose.
final List<String> lifecycleLog = <String>[];

void main() => runApp(const LabApp());

// Keep the name LabApp and its const constructor: the checker uses them.
class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Study Tracker',
      home: HomePage(),
    );
  }
}

// Step 1: HomePage widget
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Tracker: $course'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StudentCard(
              name: studentName,
              roll: rollNo,
              course: course,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Start: $startCount', key: const Key('info-start')),
                Text('Step: $stepSize', key: const Key('info-step')),
                Text('Max: $maxCount', key: const Key('info-max')),
              ],
            ),
            const SizedBox(height: 12),
            // Step 4.3: Add GoalBanner below info Row
            GoalBanner(count: startCount, max: maxCount),
          ],
        ),
      ),
    );
  }

  // Think (Step 3): Draw the widget tree of your screen on paper, from LabApp down to the three Text widgets.
  // How many levels deep is the Text ('Max: ...')?
  // Answer: The hierarchy is:
  // 1. LabApp -> 2. MaterialApp -> 3. HomePage -> 4. Scaffold ->
  // 5. SingleChildScrollView -> 6. Column -> 7. Row -> 8. Text('Max: ...')
  // It is exactly 8 levels deep.
}

// Step 2: StudentCard widget
class StudentCard extends StatelessWidget {
  final String name;
  final String roll;
  final String course;

  const StudentCard({
    super.key,
    required this.name,
    required this.roll,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: $name', key: const Key('student-name')),
            Text('Roll no: $roll', key: const Key('student-roll')),
            Text('Course: $course', key: const Key('student-course')),
          ],
        ),
      ),
    );
  }

  // Think (Step 2): Why are the fields of a StatelessWidget final? What would the compiler say if you removed final?
  // Answer: Widgets in Flutter are immutable configurations. Because StatelessWidget inherits the
  // @immutable annotation, removing 'final' triggers a compiler/analyzer warning stating that an
  // immutable class cannot contain non-final instance fields.
}

// Step 4: GoalBanner widget
class GoalBanner extends StatelessWidget {
  final int count;
  final int max;

  const GoalBanner({
    super.key,
    required this.count,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    // Task 4.2: Integer division for percentage
    final int percent = count * 100 ~/ max;
    return Text(
      'Progress: $count of $max ($percent%)',
      key: const Key('progress'),
    );
  }

  // Think (Step 4): Why does GoalBanner not need setState? What would you have to do to make it show a new count?
  // Answer: GoalBanner is a StatelessWidget whose build output depends strictly on the parameters passed
  // into its constructor. It has no internal mutable state. To make it show a new count, its parent widget
  // must rebuild and instantiate a new GoalBanner with the updated count value.
}

// ---- Provided for Step 7. It has a bug on purpose. Do not rename anything.
class BuggyCounter extends StatefulWidget {
  const BuggyCounter({super.key});

  @override
  State<BuggyCounter> createState() => _BuggyCounterState();
}

class _BuggyCounterState extends State<BuggyCounter> {
  int _clicks = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Bug clicks: $_clicks', key: const Key('bug-text')),
        const SizedBox(width: 12),
        ElevatedButton(
          key: const Key('bug-button'),
          onPressed: () {
            _clicks += bugStep;
          },
          child: Text('+$bugStep'),
        ),
      ],
    );
  }
}