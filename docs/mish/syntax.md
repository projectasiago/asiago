---
title: Mish Syntax
---

[back](./)

## Mish Syntax

Mish syntax here.

### Variables

Mish is strongly typed, but types are inferred.

```
let x = 10 ?? types are inferred here
let y: Num = 10 ?? you may also expicitally specify the type with a type annotation
```

You may also assign a variable and the variable will store the new value:

```
x = 15
y = 15
```

You may also declare a variable without assigning a value to it. However, when you do this, you won't be able to use it later on without causing a compile-time error. The variable must be assigned before using it.

```
let x
x = 10
```

### Comments

```
let x = 10 ?? single-line comment
?? a single-line comment can also go on a line with no content
??-
block comment
-??
??? documentation comment
???-
documentation block comment
-???
```

### Common types

 - Void - indicates lacking of a value
 - String - can store text
 - Integer - can store integers
 - Decimal - can store decimals
 - Fraction - can store fractions
 - Number, Num - can store integers, decimals, and fractions

### Literals

```
let x: () = ()
let x: String = "text"
let x: Integer = 15 ?? decimal
let x: Integer = 0xF ?? hexadecimal
let x: Integer = 0b0011 ?? binary
let x: Integer = 0o15 ?? octal
let x: Integer = 123_456 ?? easier reading of numbers
let x: Integer = 5k ?? thousand
let x: Integer = 5m ?? million
let x: Integer = 5g ?? billion
let x: Integer = 5t ?? trillion
let x: Integer = 5p ?? quadrillion
let x: Integer = 5e ?? quintillion
let x: Integer = 5z ?? sextillion
let x: Integer = 5y ?? septillion
```

### Strings

```
let hello = "Hello"
let helloWorld = "$hello World!"
let helloWorld = "$(hello + " World!")"
```

Escape characters:

 - `\"` - double quote
 - `\$` - dollar sign

### Maths

```
3 + 3 == 6
3 * 3 == 9
3 ** 3 == 27

6 - 3 == 3
9 / 3 == 3
27 // 3 == 3

true & true == true
true & false == false
false & false == false

true | true == true
true | false == true
false | false == false

!true == false
true! == false
```

### Expression Operator Precedence

Items on the same level evaluate left to right.

 - `? :`
 - `&`, `|`, `^` - these are logical, not bitwise; &=and, |=or, ^=xor
 - `==`, `!=`
 - `<`, `>`, `<=`, `>=`, `< <`, `< <=`, `<= <`, `<= <=`
 - `+`, `-`
 - `*`, `/`, `%`
 - `**`, `//`
 - `&&`, `||`, `^^`, `<<`, `>>` - &&=and, ||=or, ^^=xor
 - `!`, `~`, `+`, `-` - !=logical not, ~=bitwise not
 - `[]`, `:` - :=function call
 - `()` and literals

Note that you can't use bitwise operators on booleans and logical operators on numbers. The operators are separate in order to differentiate between precedence levels. While these precedence levels *could* be inferred based on the type of the input, that's too complicated.

### Collections

```
let list: []String = []
let map: [Integer]String = []

list << "cat"
assert list[0] == "cat"
```

### Control Flow

#### Branching
```
let x = 10
if x == 10 {
	?? this will execute
} else {
	?? this will not
}

match x {
	10 -> print: "x is 10"
	_ -> print: "x is something else" ?? in-fact, this will be a compile-time warning since x is always 10
}

let x = 10
match typeof x {
	Integer -> ...
	_ -> ... ?? compile-time warning: x cannot be anything other than an Integer
}
```

These statements can also be used as expressions:
```
let x = 10
let y = if x == 10 {
	:: 5
} else {
	:: 1
}
assert y == 5

y = match x {
	10 -> 5
	20 -> { :: 1 }
	_ -> { print: @ } ?? compile-time error: no yielding
}
assert y == 5
```

```
let y = if c {
	print: "hi" ?? compile-time error: no yielding
}
```

#### Looping
```
loop {
	?? this will loop forever
}

let cond = true
while cond {
	?? this will loop while cond is true
}

let list = [1]
each list {
	assert @ == 1
}

for list.enumerate:() {
	assert @.index == 0
	assert @.item == 1
}
```

Using the keyword `break` inside one of these loop will exit the loop regardless of the loop condition.

Using the keyword `continue` inside one of these loops will skip to the next iteration.

### Functions

```
fn hello: Integer -> String {
	:: @.toString()
}

let x: String = hello: 5
```

The syntax of the function is like so:

```
fn <function name>: <input type> [ -> <output type> ] { <function body> }
```

Note that unlike most other languages, Mish functions only accept one input parameter. This parameter is not named and is referenced by the `@` symbol.

Functions can be called like so:

```
<function name>: <input value>
```

For void-input functions, you can do this:

```
fn generate:() -> String {
	:: "Hello, World!"
}
let x: String = generate:()
```

If you want to store a function in a variable (sometimes called a closure or a lambda), you can do this:

```
let func: Input -> Output = @{ ... }
```

#### Pure Functions
Pure functions are marked with the `pure` modifier:
```
pure fn add:[]Number -> Number {
	let result = 0
	loop @ {
		result += @
	}
	:: result
}
```
Pure functions cannot modify state. They can only take input, generate an output, and call other pure functions. They cannot mutate the input if it is passed by reference. Functions may be marked as pure implicitly.

#### Short Functions
(for lack of a better name) Short functions are ones which don't allow looping or recursion.
```
short fn booleanToString:Boolean -> String {
	:: match @ {
		true -> "true"
		false -> "false"
	} 
}
```

#### Pure Short Functions
```
pure short fn xyz:In -> Out { ... }
```

### Tagging Blocks

You might see that there can be some ambiguity about which block to yield from. This is resolved by tagging.

In this scenario, we demonstrate returning from the function as well as assigning to the `x` variable:
```
fn animalFun:Boolean -> String {
	let x = if @ {
		:: "cat" ?? x = "cat"
	} else {
		:animalFun: "dog" ?? function returns "dog" 
	}
	:: x
}
```

In this scenario, we demonstrate the same thing, but this time tagging the if statement explicitly.
```
fn animalFun2:Boolean -> String {
	let x = tag ifStatement if @ {
		:ifStatement: "cat" ?? x = "cat"
	} else {
		:animalFun2: "dog" ?? function returns "dog" 
	}
	:: x
}
```

This becomes more useful when dealing with nested loops:
```
tag outer for [1, 2, 3, 4, 5] {
	let outerVal = @
	tag inner for [1, 2, 3, 4, 5] {
		if outerVal = @ {
			break inner
		} else {
			continue outer
		}
	}
}
```

### Permission

Declare the permission like this:

```
pemission PEat
```

Usage with functions:

```
fn eat:Output -> Output requires PEat { ... }
let eat: Input -> Output requires PEat = { ... }
```

This means that you won't be able to call `eat` unless you have the `PEat` permission.

```
class Society {
	permission PEat ?? new permission PEat is declared and is granted to surrounding context
	delegate PEat to Human ?? Human now has the PEat permission. If it didn't ask for it via haspermission, this would be an error.
	
	fn obtainPermission:{ password: String; task: () -> () requires PEat } -> Boolean {
		if @.password == "1234" {
			@:()
			:: false
		} else {
			:: true
		}
	}
	
	fn doSomeEating:() -> () requires PEat { ... }
	
	fn secretFunction:() -> () {
		?? Can call doSomeEating fine without requireing the caller of secretFunction to first obtain the PEat permission.
		?? This is essentally a security hole in the Society class.
		doSomeEating:()
	}
}

let society = Society {}

class Human haspermission PEat { ?? if we weren't delegated PEat, this would be an error
	fn go:() -> () {
		society.doSomeEating:() ?? Human was granted PEat so we are allowed to call this function
	}
}

?? dynamic permission obtaining

let failed = society.obtainPermission: {
	password: "1234"
	task: @ requires Society::PEat {
		society.doSomeEating:()
	}
}

if failed {
	?? handle permission failure
}
```

### Constraints

Constraints allow code to define a range of values numbers can be in.

```
let a: Num(min 5, max 10) = 7
let b = a ?? b implicitly has type: Num(min 5, max 10)
let c = b + 1 ?? c implicitly has type: Num(min 6, max 11)
```

#### How?

Implicit types. Mish will generate implicit types for variables. If you specify the type to be `Num` but only assign a 5 to it, Mish will implicitly set the type to be `Num(min 5, max 5)`. If you call a function, Mish will go into this function and generate implicit types based on the input arguments and produce a more constrainted, implicit, return type than what the function was originally declared to return.

```
?? ...continuing from above

fn add:(Num, Num) -> Num {
	return @[0] + @[1]
}

let d = add(a, c) ?? add:[0] implicitly has type: Num(min 5,max 10), add:[1] implicitly has type: Num(min 6,max 11), add:-> implicitly has type: Num(min 11,max 21)

let x = 5 ?? Num(min 5,max 5)
for i in [0..2] {
	x++
}
?? here, x is Num(min 8,max 8)

let input: Num(min0,max:infinity) = input:() ?? validation not shown
for i in [0..input] {
	x++
}
?? here, x is Num(min 8,max infinity)
```

As these loops get more complicated, it will start to require some calculus to determine the end-behavior of these sections of code. Yay!

### Variable types

```
let a = 5
a = () ?? compile-time error

let b: Integer | () = 5
b = () ?? ok!

if b != () {
	?? b is implicitly an Integer
}

let x: Value1 | Value2 | Value3 = ...
match typeof x {
	Value1 -> ...
	Value2 -> ...
	Value3 -> ...
}
```

### Bindings

Mish supports binding an expression to a variable. This means that the variable will always contain the contents of the expression. Any function calls in these expressions must be pure and functions.

```
let x = 5
let y := x
x = 10
assert y == 10
```

Use equal signs to indicate that we should capture the contents of the variable at this moment and not watch for changes.

```
let x = 5
let y := =x + 1
assert y == 6
x = 10
assert y == 6
```

Watch changes to a variable. Any function calls in watchers must be short functions.

```
let x = 5
watch x @{
	assert @.old == 5
	assert @.new == 10
}
x = 10
```

Watch changes to a variable and run the listener now.

```
let x = 5
watchnow x @{
	assert @.old == 5
	assert @.new == 5
	assert @.first ?? @.first will be true on the first time this listener is called
}
```

Note that expression bindings will evaluate synchronously, whereas watchers will execute asynchronously.

## Classes

All their members are private by default.

```
class Rectange {
	pub x: Num(min 0, max infinity)
	pub y: Num(min 0, max infinity)
	pub width: Num(min 0, max infinity)
	pub height: Num(min 0, max infinity)
	
	pub fn area:() -> Num {
		:: this.width * this.height
	}
}
```

### Static Variables

When a function is defined inside a class, they are able to store state within the scope of the function.
```
class IdDealer {
	fn newId:() -> Number {
		static id = 0
		id++
		::id
	}
}
```

Note: there is no "static" variables like there is in Java as this would conflict with the idea that modules do not store state.

### Subclassing
```
class Animal {
	pub fn speak:() -> String
}

class Dog: Animal {
	pub fn speak:() -> String {
		:: "Woof!"
	}
}
```

### Access Levels

 - `piv` - the default access level, only this class can access this member
 - `sub` - only this class and its sub-classes can access this member
 - `spc` - only this space can access this member (not subclasses)
 - `pub` - anybody can access this member

You can also set more fine-grained control over who can read/write the value with `com`. In the example below, anybody can read, while only the class itself can write.

```
class Something {
	com(read pub, mut piv) var: Type
}
```

## Enums
```
enum Operation [
	Quit,
	Message String,
]

let op = ...
match op {
	Quit -> { quit:: }
	Message -> { print: @ }
}
```

## Spaces
```
space space1 {
	fn hello:() { ... }
}

space space2 {
	fn go:() {
		space1.hello:()
	}
}
```

Imports bring the given symbol into the scope where the import is (as well as any sub-scopes):
```
space space1 {
	pub let x = 5
	pub let y = 10
}

import space1.x
fn go:() -> () {
	print: x
	print: z ?? compile-time error: z is defined below
	
	import space1.x as z
	print: z
}

space space2 {
	import space1.y
}

space space3 {
	print: y ?? compile-time error...y is only available inside space1 or space2
}
```

## Modules
All modules are pure. They cannot contain any global state. Any state must be stored inside an instance of a class (which this state must be stored elsewhere). All references to state (volatile and not) are stored in the root module.

Modules are referenced by their key and hash code (known collectively as a module identifier or mod ID). The key is the public key of the entity that created and maintains the module. The hash code is, well, the hash of the entire module. When modules are distributed, the mod ID is given out. Each symbol in the module (manifest, space, sub spaces, individual classes, and functions) is signed. When the module (or parts of it) are loaded from an external source, each symbol and its contents are verified against the key. The loading mechanism should be smart enough to only download the symbols that are needed for the thing to function.

Modules cannot reference one another. Here is an example of a plugin-type system.

Interface module:
```
?? The plugin uses this to reference the system.
trait Platform {
	fn doPlatform:() -> ()
}

?? The platform uses this to reference the plugin.
trait Plugin {
	fn doPlugin:() -> ()
}
```

Platform module (depends on the Interface module):
```
import mod_interface.{Plugin, Platform}
fn platformFunction:() -> { ... }
fn go:() -> () {
	let platform: Platform = Platform {
		doPlatform = { platformFunction:() }
	}
	let module: Module<Platform, Plugin> = moduleReference:"123ABC" ?? not shown: verifying the module is of type Platform -> Plugin and the potential for the module not existing or not found
	let plugin: Plugin = module.init: platform
	plugin.doPlugin:()
}
```

In the code above, the function `moduleReference` is something magically provided by the OS which allows downloading modules. This mechanism is up for debate, but will probably be implemented in Mish by the root module.

Plugin module (depends on the Interface module):

```
import mod_interface.{Plugin, Platform}
let platform: Platform = @
:: Plugin {
	doPlugin = {
		doSomeStuff:()
	}
}

fn doSomeStuff:() -> () {
	myspace.insideSpace:()
}

space myspace {
	fn insideSpace:() -> {
		...
	}
}
```

### Module dependencies
What's not shown above is where the mod IDs come into play. When one module wants to depend on another, one way is to directly reference the mod ID using:
```
mod 123ABC as mod_interface
```
Where `123abcXYZ` is the mod ID (a base-62 encoded version of it) and `mod_interface` is the name given. The name is arbitrary and is the name used to reference the module. Modules must be referenced using only the `mod` statement and cannot be directly referenced (e.g. `123abcXYZ.someFunction:()`).

IDEs may implement a variety of mechanisms to make referencing modules easier for the developer. One example would be the `group:module:version` labeling. There could be services which host mappings between `group:module:version` and the mod ID. In this case, the developer would tell the IDE which modules (using the more readable syntax) to depend on. The IDE will transparently inject `mod` statements into the code.

As an example, lets say the developer depended on `chris13524:maths:1.0.0`. The IDE would lookup the mod ID for this (let's say it's `12AB`) and will prepend the source code with these lines:
```
space chris13524 {
	mod 12AB as maths
}
```

Your source file would then have access to the module using `chris13524.maths.sin:10`.