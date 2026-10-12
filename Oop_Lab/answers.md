Task 1

Think: Why is item.pages a compile error even though the object really has pages?

Answer: Dart performs static type checking at compile time. Variable 'item' is declared with the type LibraryItem, which does not define a 'pages' field.
