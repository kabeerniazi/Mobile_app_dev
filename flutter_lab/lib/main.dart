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
            const Tally(),
            const SizedBox(height: 12),
            const Countdown(),
            const SizedBox(height: 12),
            const BuggyCounter(),
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

// Step 5 & 6: Tally StatefulWidget and State
class Tally extends StatefulWidget {
  const Tally({super.key});

  @override
  State<Tally> createState() => _TallyState();
}

class _TallyState extends State<Tally> {
  int _count = startCount;

  void _plus() {
    setState(() {
      _count += stepSize;
      if (_count > maxCount) _count = maxCount;
    });
  }

  void _minus() {
    setState(() {
      _count -= stepSize;
      if (_count < 0) _count = 0;
    });
  }

  void _reset() {
    setState(() {
      _count = startCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Count: $_count', key: const Key('count')),
        GoalBanner(count: _count, max: maxCount),
        Row(
          children: [
            ElevatedButton(
              key: const Key('plus'),
              onPressed: _plus,
              child: Text('+$stepSize'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              key: const Key('minus'),
              onPressed: _minus,
              child: Text('-$stepSize'),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              key: const Key('reset'),
              onPressed: _reset,
              child: const Text('Reset'),
            ),
          ],
        ),
      ],
    );
  }

  // Think (Step 6): Hot reload while the count is 12. Does it stay 12? Now do a hot restart. Explain the difference using the words widget and State.
  // Answer: On hot reload, the count stays 12 because Flutter rebuilds the widget tree while preserving existing State objects in memory.
  // On hot restart, the count resets to startCount because Flutter destroys all State objects and reinitializes the entire application from scratch.
}

// Step 8 & 9: Countdown StatefulWidget with build counter and lifecycle logging
class Countdown extends StatefulWidget {
  const Countdown({super.key});

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  late int _left;
  late Timer _timer;
  int _builds = 0; // Task 9.1: Build counter

  @override
  void initState() {
    super.initState();
    // Task 9.2: Record initState
    lifecycleLog.add('initState');
    _left = startSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _left--);
      if (_left <= 0) timer.cancel();
    });
  }

  @override
  void dispose() {
    // Task 9.2: Record dispose before super.dispose()
    lifecycleLog.add('dispose');
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Task 9.1: Increment on every build execution
    _builds++;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _left > 0
            ? Text('Time left: $_left s', key: const Key('time-left'))
            : const Text('Time is up!', key: const Key('time-left')),
        Text('Builds: $_builds', key: const Key('builds')),
      ],
    );
  }

  // Think (Step 8): What error appears in the console if you delete the _timer.cancel() from dispose and the widget is removed?
  // Answer: The periodic timer continues running in the background and attempts to call setState() on an unmounted State object.
  // This causes Flutter to throw an exception: "FlutterError (setState() called after dispose(): _CountdownState#... was already disposed)".

  // Think (Step 9): Why does it increase by one per second and not by two? Where could you print lifecycleLog to prove that dispose ran?
  // Answer: It increases by one per second because Timer.periodic fires once every second, invoking setState() exactly once per tick,
  // which schedules a single build pass. You could print lifecycleLog inside an automated test after pumping widget disposal,
  // in a parent route's transition observer, or inside a top-level route pop listener after the Countdown widget unmounts.
}

// Step 7: BuggyCounter with setState fix
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
            setState(() {
              _clicks += bugStep;
            });
          },
          child: Text('+$bugStep'),
        ),
      ],
    );
  }

  // Think (Step 7): Before the fix, you tapped three times. What was the value of clicks inside the State,
  // and what did the screen show? Write both numbers (you need the first for ANSWERS.md, A3).
  // Answer: Value of _clicks inside State was 6 (3 taps * bugStep of 2). The screen showed 0.
}