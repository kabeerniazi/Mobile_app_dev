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

Task 8

 Think: Delete your hashCode and run again. What happens to the set size, and why does Dart expect both == and hashCode together?

 Answer: The set size becomes 3. Hash-based collections use hashCode to look up hash buckets first. Without matching hashCodes, distinct object instances are stored in different buckets and never evaluated with ==.

Task 9 

 Think: Why can created be read as LibraryItem.created without making any object first?
 
  Answer: Static members belong to the class definition namespace itself in memory, not to any individual instance of the class.

 Wrap-Up Reflection Answers

Q1. What can a subclass using extends use for free that a class using implements has to write itself?
A subclass using `extends` inherits concrete method bodies, constructors, and field storage from the superclass. In contrast, a class using `implements` treats the parent solely as an interface contract and must write out its own implementation for every single method, getter, and setter.

Q2. Book and Dvd both use Renewable. When would you pick a mixin, and when an abstract parent class?  
Pick an abstract parent class when modeling an "is-a" hierarchical relationship where all subclasses fundamentally share common state and identity. Pick a mixin when you need to share modular behavior horizontally across specific classes without forcing that behavior onto unrelated sibling classes (like `Magazine`).

Q3. Why must you override hashCode whenever you override ==?
Hash-based collections (`Set` and `Map`) determine an object's storage bucket using its `hashCode` before testing for equality with `==`. If two objects evaluate to equal via `==` but have different `hashCode` values, collections place them in different buckets and fail to identify them as the same item.

Q4. An extension method on String and a subclass of String both add behaviour. Why does Dart let you write the first one but not the second?  
Extension methods are resolved statically at compile time without altering the underlying class's layout or memory structure. Subclassing `String` is forbidden because `String` is a final, optimized core platform type whose internal runtime representation cannot be safely modified.
