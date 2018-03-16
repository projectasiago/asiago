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
let x: Void = ()
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

### Functions

```
fn hello: Integer -> String {
    return @.toString()
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
    return "Hello, World!"
}
let x: String = generate:()
```

If you want to store a function in a variable (sometimes called a closure or a lambda), you can do this:

```
let func: Input -> Output = @{ ... }
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
			return false
		} else {
			return true
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
let a: Num(min: 5, max: 10) = 7
let b = a ?? b implicitly has type: Num(min: 5, max: 10)
let c = b + 1 ?? c implicitly has type: Num(min: 6, max: 11)
```

#### How?

Implicit types. Mish will generate implicit types for variables. If you specify the type to be `Num` but only assign a 5 to it, Mish will implicitly set the type to be `Num(min:5, max:5)`. If you call a function, Mish will go into this function and generate implicit types based on the input arguments and produce a more constrainted, implicit, return type than what the function was originally declared to return.

```
?? ...continuing from above

fn add:(Num, Num) -> Num {
	return @[0] + @[1]
}

let d = add(a, c) ?? add:[0] implicitly has type: Num(min:5,max:10), add:[1] implicitly has type: Num(min:6,max:11), add:-> implicitly has type: Num(min:11,max:21)

let x = 5 ?? Num(min:5,max:5)
for i in [0..2] {
	x++
}
?? here, x is Num(min:8,max:8)

let input: Num(min0,max:infinity) = input:() ?? validation not shown
for i in [0..input] {
	x++
}
?? here, x is Num(min:8,max:infinity)
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
```

### Bindings

Mish supports binding an expression to a variable. This means that the variable will always contain the contents of the expression.

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

Watch changes to a variable.

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