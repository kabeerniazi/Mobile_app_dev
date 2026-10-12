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

Task 5

Think: Book and Dvd need the same renew code but Magazine must not have it. Why is a mixin a better fit than putting renew in LibraryItem?

 Answer: Putting renew in LibraryItem forces all subclasses (including Magazine) to inherit it. A mixin allows selective horizontal reuse across Book and Dvd without polluting the base class.

 Task 6

 Think: Why is MemberType.student safer than the string 'student'?

  Answer: Enums provide compile-time type safety and IDE autocomplete,  preventing subtle bugs caused by typos in raw string literals.

task 7

Think: What do you gain by writing 72.rs instead of rs(72)?

Answer: Extension methods provide a fluent dot-notation syntax, enhancing readability and code discoverability without wrapping values in nested function calls.
}
