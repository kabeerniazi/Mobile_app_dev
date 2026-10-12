Task 1

Think: Why is item.pages a compile error even though the object really has pages?

Answer: Dart performs static type checking at compile time. Variable 'item' is declared with the type LibraryItem, which does not define a 'pages' field.

Task 2
Think: What would happen to the output if you forgot @override and mistyped the method name as descibe()?

Answer: Dart would treat descibe() as a new method on Magazine rather than an override. Calling describe() would invoke the parent LibraryItem.describe(), omitting ", issue <issue>".

Task3

 Think: Temporarily try LibraryItem('x', 2000). Read the error. Why can you not create an abstract class directly?

 Answer: Abstract classes serve as incomplete contracts and may define methods without bodies (like lateFee). Instantiating one directly would lead to runtime failures if an unimplemented method were invoked.

 TASK 4

  Think: You wrote all three method bodies yourself. What would extends Borrowable have given you for free, and why is that not what you wanted?

 Answer: 'extends' allows inheriting concrete method implementations. Here Borrowable has no bodies, and Dart does not support multiple class inheritance since Book already extends LibraryItem.

