Task 1

Think: Why is item.pages a compile error even though the object really has pages?

Answer: Dart performs static type checking at compile time. Variable 'item' is declared with the type LibraryItem, which does not define a 'pages' field.

Task 2
Think: What would happen to the output if you forgot @override and mistyped the method name as descibe()?

Answer: Dart would treat descibe() as a new method on Magazine rather than an override. Calling describe() would invoke the parent LibraryItem.describe(), omitting ", issue <issue>".
