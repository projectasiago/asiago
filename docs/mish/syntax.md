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
let helloWorld = "$(hello + " World!)"
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

`? :`
`&`, `|`, `^` - these are logical, not bitwise; &=and, |=or, ^=xor
`==`, `!=`
`<`, `>`, `<=`, `>=`, `< <`, `< <=`, `<= <`, `<= <=`
`+`, `-`
`*`, `/`, `%`
`**`, `//`
`&&`, `||`, `^^`, `<<`, `>>` - &&=and, ||=or, ^^=xor
`!`, `~`, `+`, `-` - !=logical not, ~=bitwise not
`[]`, `:` - :=function call
`()` and literals

Note that you can't use bitwise operators on booleans and logical operators on numbers. The operators are separate in order to differentiate between precedence levels. While these precedence levels *could* be inferred based on the type of the input, that's too complicated.

### Functions

```
fn hello: Integer -> String @{
    return @.toString()
}

String x = hello: 5
```

The syntax of the function is like so:

```
fn <function name>: <input type> -> <optional output type> @{ <function body> }
```

Functions can be called like so:

```
<function name>: <input value>
```

For void-input functions, you can do this:

```
fn generate:() -> String @{
    return "Hello, World!"
}
String x = generate:()
```

If you want to store a function in a variable (sometimes called a closure or a lambda), you can do this:

```
Function<Input, Output> func = @{ ... }
```

### Guarentees

Guarentees are things that make it possible to assert some sort of guarentee about the state of a system. They're meerly a flag that propogates through the call stack.

```
guarentee PermissionEat;
```

Usage with functions:

```
fn eat:() -> () requires PermissionEat @{ ... }
Requires<Function<Input, Output>, PermissionEat> eat = @{ ... }
```

Now this means that you won't be able to call the `eat()` function unless you have the `PermissionEat` guarentee.

You can't make something out of nothing, so in order to obtain this guarentee initially, you must specify the things that can grant this guarentee:

```
guarentee PermissionEat grantedby Society;

class Society {
    fn doWithEatPermission:Requires<Function<Void, Void>, PermissionEat> @{
        grant PermissionEat {
            @()
        }
    }
}
```
