# Lab: Study Tracker - Reflection & Numerical Answers
**Course:** CS 442 | Mobile Application Development  
**Name:** Muhammad Kabeer Khan  
**Roll No:** 04072313029  

---

### Part A: Numerical Answers

* **A1:** 4
* **A2:** 11
* **A3:** 6
* **A4:** 50

---

### Part B: Written Answers

**B1: Which of your classes are Stateless and which are Stateful, and why?**  
* **Stateless (`LabApp`, `HomePage`, `StudentCard`, `GoalBanner`):** These widgets contain only final configuration properties and produce predictable UI output solely from constructor arguments. They do not maintain dynamic, mutable state across frame rebuilds.
* **Stateful (`Tally`, `Countdown`, `BuggyCounter`):** These widgets have state that changes over time (interactive count, periodic countdown timer, and button clicks). They use a separate `State` class that persists across rebuilds to track runtime mutations and trigger UI refreshes via `setState()`.

**B2: Why must the Timer be cancelled in `dispose()`?**  
Periodic timers are registered on the Dart event loop outside Flutter's widget tree. If a timer is not cancelled when the widget is unmounted, it continues firing in the background, causing memory leaks and invoking `setState()` on an already disposed State object, which throws an unhandled `FlutterError`.

**B3: Which widgets in your code can be const, and what const buys you?**  
Widgets whose configuration is fully known at compile-time (such as `LabApp`, `HomePage`, `Tally`, `Countdown`, `BuggyCounter`, `SizedBox`, and fixed `Text` widgets) can be instantiated with `const`. Using `const` canonicalizes widget instances in memory so Flutter reuses the exact same instance rather than allocating new objects, allowing the framework to short-circuit subtree comparisons and avoid unnecessary rebuilds.