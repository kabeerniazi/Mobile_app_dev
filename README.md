# CS 442 Week 1 Lab: Enhanced Counter App

## Student Details

- **Name:** Kabeerniazi
- **Roll number:** 04072313029
- **Threshold:** 34 (`029 + 5`)
- **Theme seed:** `Colors.teal` fallback, because no standard Material `Colors` value starts with `K` or `N`

## Features

- Increment counter button using `Icons.add`
- Reset counter button using `Icons.refresh`
- Reset usage tracker displayed as `Resets used: N`
- “You're on a roll!” appears in green only when the counter exceeds `myThreshold`
- Personalized theme using `colorSchemeSeed: mySeedColor`
- About line showing the student name and roll number

## Screenshot

The screenshot below should show the counter above the threshold, the threshold message, and at least one reset already performed.

![Enhanced counter app](<img width="1576" height="852" alt="image" src="https://github.com/user-attachments/assets/ae2334b4-1c61-493e-8431-f6a0b756d821" />)


## Reflection

`setState(() { ... })` tells Flutter that the state of a `StatefulWidget` has changed and that its UI should be rebuilt. The values can change in memory without it, but Flutter will not automatically run `build()` again to display those new values. In this app, `setState()` refreshes the counter, the reset message, and the reset tracker after a button is pressed.

## Running the App

```bash
flutter pub get
flutter run
```
For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
