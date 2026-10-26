A1: 20
A2: 6
A3: 4
A4: 60

B1: 
- Stateless widgets (`HomePage`, `SettingsCard`, `SummaryRow`, `Probe`, `Welcome`, `InfoPanel`, `ShareRow`, `InfoBox`, `StampStack`) are immutable configurations that do not change over time and only depend on their initialization arguments or global configurations.
- Stateful widgets (`Clock`, `Tile`, `SwapBoard`) maintain internal mutable state (`State` objects) that can change dynamically during the lifecycle of the widget via `setState()`.

B2: 
- On every `setState()`, the **Widget** configuration is newly instantiated and rebuilt, while the **Element** and **State** objects are preserved and kept in the tree.
- The Probe output demonstrated that the widget instance hash code changes on every tick, whereas the Element hash code remains completely constant.

B3: 
- "Constraints go down, sizes go up" means that parent widgets pass layout constraints (minimum and maximum dimensions) down to their children. Based on those constraints, the children compute and report their actual size back up to the parent. For instance, in Step 7, `Expanded` forces the `Text` widgets down the constraint tree to fit within an equal slice of the total Row width, causing them to wrap into multiple lines rather than overflow horizontally.