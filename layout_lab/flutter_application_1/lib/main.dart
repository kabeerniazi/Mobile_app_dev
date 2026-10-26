// main.dart - Team Board lab
import 'dart:async';
import 'package:flutter/material.dart';

const String studentName = 'Muhammad Kabeer Khan';
const String rollNo = '04072313029'; // e.g. '21F-0347'

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit

const List<String> courses = [
  'Mobile Dev', 'Data Structures', 'Operating Systems', 'Databases',
  'Networks', 'Software Eng', 'AI', 'Web Engineering', 'Graphics', 'Security',
];
const List<String> names = ['Ali', 'Sara', 'Omar', 'Hina', 'Zain', 'Maya'];
const List<String> mains = [
  'start', 'center', 'end', 'spaceBetween', 'spaceAround', 'spaceEvenly',
];
const List<String> crosses = ['start', 'center', 'end'];
const List<String> hues = ['teal', 'indigo', 'orange', 'pink', 'green'];
const Map<String, MaterialColor> swatches = {
  'teal': Colors.teal,
  'indigo': Colors.indigo,
  'orange': Colors.orange,
  'pink': Colors.pink,
  'green': Colors.green,
};

final String course = courses[u];

// Steps 1-2: the clock
final int startSec = 5 * (1 + t % 5);
final int tick = 1 + u % 3;
final int ticks = 4 + u % 4;
final int stopAt = startSec + ticks * tick;

// Steps 4-5: the tiles
final String tileA = names[u % 6];
final String tileB = names[(u + 2) % 6];
final String tileC = names[(u + 4) % 6];
final int tapsToMake = 2 + t % 3;

// Step 6: axes
final String mainName = mains[u % 6];
final String crossName = crosses[t % 3];

// Step 8: Expanded and Flexible
final double fixedW = 70.0 + 10 * u;
final int flexA = 1 + t % 3;
final int flexB = 1 + u % 2;

// Step 9: Container
final double boxMargin = 4.0 + 2 * (t % 5);
final double boxPad = 8.0 + 2 * (u % 5);
final double boxRadius = 4.0 * (1 + (t + u) % 4);
final double boxBorder = 1.0 + t % 3;
final String hue = hues[(t + u) % 5];

// Step 10: Stack
final double dotTop = 4.0 + 4 * (t % 4);
final double dotRight = 4.0 + 4 * (u % 4);
final double dotBottom = 4.0 + 4 * ((t + u) % 4);
final double dotLeft = 4.0 + 4 * ((t + 2 * u) % 4);

final List<String> lifecycleLog = <String>[];

void main() => runApp(const LabApp());

class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Team Board', home: HomePage());
  }
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Team Board: $course')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingsCard(),
            SizedBox(height: 12),
            Welcome(),
            SizedBox(height: 12),
            Clock(),
            SizedBox(height: 12),
            SwapBoard(),
            SizedBox(height: 12),
            InfoPanel(),
            SizedBox(height: 12),
            SummaryRow(),
            SizedBox(height: 12),
            ShareRow(),
            SizedBox(height: 12),
            InfoBox(),
            SizedBox(height: 12),
            StampStack(),
          ],
        ),
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'YOUR SETTINGS (seed $seed)\n'
      'clock: start $startSec, tick $tick, stop at$stopAt\n'
      'tiles: $tileA,$tileB, $tileC (taps for the Step 5 experiment:$tapsToMake)\n'
      'row main axis: $mainName \vert{} column cross axis:$crossName\n'
      'flex: $flexA and $flexB \vert{} fixed width:${fixedW.toStringAsFixed(0)}\n'
      'box: margin $boxMargin, padding $boxPad, radius$boxRadius, '
      'border $boxBorder, colour$hue\n'
      'stamp: top $dotTop, right$dotRight, bottom $dotBottom, left$dotLeft',
      key: const Key('settings'),
      style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
    );
  }
}


// Step 2: dispose, build count, lifecycleLog
// Think answer: Builds goes up by one per second because each tick triggers exactly one setState().
// If _timer.cancel() were omitted from dispose, the periodic timer would keep firing and calling 
// setState() on an unmounted State object, throwing 'setState() called after dispose()'.
class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  late Timer _timer;
  int _seconds = startSec;
  int _builds = 0;

  @override
  void initState() {
    super.initState();
    lifecycleLog.add('initState');
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _seconds += tick);
      if (_seconds >= stopAt) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    lifecycleLog.add('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _builds++;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Session: $_seconds s', key: const Key('clock')),
        Text('Builds: $_builds', key: const Key('builds')),
      ],
    );
  }
}

// Step 3: BuildContext: Widget vs Element
// Think answer: Widget is the immutable configuration blueprint that is cheap and thrown away on 
// every rebuild. Element is the persistent node in the tree that manages lifecycle and keeps State.
// The RenderObject lives in the render tree; it handles layout, sizing, and painting.
class Probe extends StatelessWidget {
  final int seconds;
  const Probe({super.key, required this.seconds});

  @override
  Widget build(BuildContext context) {
    final bool above = context.findAncestorWidgetOfExactType<Scaffold>() != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Seen at: $seconds s', key: const Key('probe-seen')),
        Text('Widget #${identityHashCode(this)}', key: const Key('probe-widget')),
        Text('Element #${identityHashCode(context)}', key: const Key('probe-element')),
        Text('Context belongs to: ${context.widget.runtimeType}', key: const Key('probe-context')),
        Text('Scaffold above me: $above', key: const Key('probe-above')),
      ],
    );
  }
}
// Step 4: Composition and Tile
// Think answer: This is called Composition (prefer composition over inheritance). Flutter prefers 
// it because assembling small single-purpose widgets creates flexible, decoupled, and declarative UIs.
class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Welcome, $studentName', key: const Key('welcome')),
    );
  }
}

class Tile extends StatefulWidget {
  final String label;
  const Tile(this.label, {super.key});

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  int taps = 0;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => setState(() => taps++),
      child: Text('${widget.label}: $taps'),
    );
  }
}

// Step 5: Keys and Swapping
// Think answer: Without keys, Flutter matches incoming widgets to existing Elements strictly by 
// runtimeType and position in the Row. When reversed, the Element and its attached State remain at 
// index 0, so the tap count stays on the left while only the widget configuration (label) updates.
class SwapBoard extends StatefulWidget {
  const SwapBoard({super.key});

  @override
  State<SwapBoard> createState() => _SwapBoardState();
}

class _SwapBoardState extends State<SwapBoard> {
  late List<Widget> tiles;

  @override
  void initState() {
    super.initState();
    tiles = [
      Tile(tileA, key: ValueKey(tileA)),
      Tile(tileB, key: ValueKey(tileB)),
      Tile(tileC, key: ValueKey(tileC)),
    ];
  }

  void swap() => setState(() => tiles = tiles.reversed.toList());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: tiles),
        ElevatedButton(
          key: const Key('swap'),
          onPressed: swap,
          child: const Text('Swap'),
        ),
      ],
    );
  }
}
// Step 6: Row and Column: Axes
// Think answer: In a Column, the main axis is vertical. The cross axis is horizontal (left to right), 
// so setting crossAxisAlignment: CrossAxisAlignment.center positions children horizontally across the width.
class InfoPanel extends StatelessWidget {
  const InfoPanel({super.key});

  MainAxisAlignment _resolveMainAxis() {
    switch (mainName) {
      case 'start': return MainAxisAlignment.start;
      case 'center': return MainAxisAlignment.center;
      case 'end': return MainAxisAlignment.end;
      case 'spaceBetween': return MainAxisAlignment.spaceBetween;
      case 'spaceAround': return MainAxisAlignment.spaceAround;
      case 'spaceEvenly': return MainAxisAlignment.spaceEvenly;
      default: return MainAxisAlignment.start;
    }
  }

  CrossAxisAlignment _resolveCrossAxis() {
    switch (crossName) {
      case 'start': return CrossAxisAlignment.start;
      case 'center': return CrossAxisAlignment.center;
      case 'end': return CrossAxisAlignment.end;
      default: return CrossAxisAlignment.start;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          key: const Key('info-row'),
          mainAxisAlignment: _resolveMainAxis(),
          children: [
            Text('Start: $startSec s', key: const Key('row-a')),
            Text('Tick: $tick s', key: const Key('row-b')),
            Text('Stop: $stopAt s', key: const Key('row-c')),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          key: const Key('info-col'),
          crossAxisAlignment: _resolveCrossAxis(),
          children: [
            Text('Name: $studentName', key: const Key('col-a')),
            Text('Roll no: $rollNo', key: const Key('col-b')),
            Text('Course: $course', key: const Key('col-c')),
          ],
        ),
      ],
    );
  }
}
// Step 7: Overflow and Expanded
// Think answer: By default, Text widgets ask for unbounded width in a Row. Expanded passes a tight, 
// bounded horizontal constraint downward to the Text. Once constrained, the Text calculates its 
// size upward by wrapping lines within that boundary.
class SummaryRow extends StatelessWidget {
  const SummaryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(
          child: Text(
            'Part A: read the widget tree of the $course board from top to bottom.',
            key: Key('sum-a'),
          ),
        ),
        Expanded(
          child: Text(
            'Part B: build each box from small widgets and never extend a builtin class.',
            key: Key('sum-b'),
          ),
        ),
        Expanded(
          child: Text(
            'Part C: break the layout on purpose, then fix it with Expanded or Wrap.',
            key: Key('sum-c'),
          ),
        ),
      ],
    );
  }
}

// Step 8: Expanded vs Flexible
// Think answer: Expanded enforces FlexFit.tight (must consume all allotted flex width), while Flexible 
// defaults to FlexFit.loose (can remain smaller than its allotted share). Swapping them would force 
// the second button to expand and allow the first to shrink.
class ShareRow extends StatelessWidget {
  const ShareRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('share-row'),
      children: [
        SizedBox(
          key: const Key('fixed'),
          width: fixedW,
          child: ElevatedButton(onPressed: () {}, child: const Text('F')),
        ),
        Expanded(
          flex: flexA,
          child: ElevatedButton(
            key: const Key('exp'),
            onPressed: () {},
            child: const Text('Exp'),
          ),
        ),
        Flexible(
          flex: flexB,
          child: ElevatedButton(
            key: const Key('flex'),
            onPressed: () {},
            child: const Text('Flex'),
          ),
        ),
      ],
    );
  }
}
// Step 9: Container
// Think answer: Padding is inside the border, while margin is outside the border.
// We use a plain Padding or SizedBox when we only need spacing without background 
// colors, borders, or rounded corner decorations, as they are much lighter widgets.
class InfoBox extends StatelessWidget {
  const InfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('info-box'),
      margin: EdgeInsets.all(boxMargin),
      padding: EdgeInsets.all(boxPad),
      decoration: BoxDecoration(
        color: swatches[hue]!.shade100,
        borderRadius: BorderRadius.circular(boxRadius),
        border: Border.all(width: boxBorder),
      ),
      child: Text('Course: $course', key: const Key('box-text')),
    );
  }
}
// Step 10: Stack and the whole screen
// Think answer 1: The size of the Stack is determined by its non-positioned children 
// (here, the 300x120 base Container).
// Think answer 2: If the Icons came first and the grey Container last, the opaque 
// Container would be painted on top, completely covering and hiding the Icons underneath.
class StampStack extends StatelessWidget {
  const StampStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: const Key('stack'),
      children: [
        Container(
          key: const Key('layer-base'),
          width: 300,
          height: 120,
          color: Colors.grey.shade300,
        ),
        Positioned(
          top: dotTop,
          right: dotRight,
          child: const Icon(Icons.star, key: Key('dot-top')),
        ),
        Positioned(
          bottom: dotBottom,
          left: dotLeft,
          child: const Icon(Icons.circle, key: Key('dot-bottom')),
        ),
      ],
    );
  }
}