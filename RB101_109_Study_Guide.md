# Study Guide

#### Table of Contents

- I. Important Concepts
  - [1. Local Variable Scope](https://github.com/kramerkeller/launch-school-2.0/blob/master/courses/109_assesment_ruby_and_general_programming/study_guide.md#1-local-variable-scope)
  - [2. Pass by Reference?](https://github.com/kramerkeller/launch-school-2.0/blob/master/courses/109_assesment_ruby_and_general_programming/study_guide.md#)
  - [3. Working with Collections](https://github.com/kramerkeller/launch-school-2.0/blob/master/courses/109_assesment_ruby_and_general_programming/study_guide.md#)
  - [4. Variables as pointers](https://github.com/kramerkeller/launch-school-2.0/blob/master/courses/109_assesment_ruby_and_general_programming/study_guide.md#)
  - [5. Puts vs return](https://github.com/kramerkeller/launch-school-2.0/blob/master/courses/109_assesment_ruby_and_general_programming/study_guide.md#)
  - [6. False vs nil and the idea of "truthiness"](https://github.com/kramerkeller/launch-school-2.0/blob/master/courses/109_assesment_ruby_and_general_programming/study_guide.md#)
  - [7. Method definition and method invocation](https://github.com/kramerkeller/launch-school-2.0/blob/master/courses/109_assesment_ruby_and_general_programming/study_guide.md#)
  - [8. Implicit return value of method invocations and blocks](https://github.com/kramerkeller/launch-school-2.0/blob/master/courses/109_assesment_ruby_and_general_programming/study_guide.md#)
- II. Explaining Code
  - [1. Common Computational Language](https://github.com/kramerkeller/launch-school-2.0/blob/master/courses/109_assesment_ruby_and_general_programming/study_guide.md#)
  - [2. What to look for](https://github.com/kramerkeller/launch-school-2.0/blob/master/courses/109_assesment_ruby_and_general_programming/study_guide.md#)
- [III. Example Code Explanations](https://github.com/kramerkeller/launch-school-2.0/blob/master/courses/109_assesment_ruby_and_general_programming/study_guide.md#)

# 

# I. Important Concepts

## 

## 1. Local Variable Scope

How local variables interact with method invocations, blocks, and method definitions <https://launchschool.com/lessons/a0f3cd44/assignments/fff0b9db>

- If a local variable and a method have the same name, the local variable takes precedence over the method call
- We can convey to ruby that we are invoking a method by passing an argument or specifying a method with "()"

```
>> puts = "variable"
=> "variable"
>> puts puts
variable      
=> nil
>> puts
=> "variable"
>> puts()
              # Blank line from puts
=> nil
>> puts "method"
method
=> nil
```

- Outer scope variables can be accessed by inner scope

- Inner scope variables cannot be accessed in outer scope 

  - unless initialized first in outer scope

- Peer scopes do not conflict

- Nested blocks follow inner outer scope rules. 

  - We just say level 1, 2, 3 etc.

- Variable Shadowing 

  - A block parameter always takes precedence over another local variable assigned outside the block in the outer scope. 

    - So if we have an outside scope variable "n" and a block parameter  "n", the block's local variable "n" will be the value passed by the the  block parameter "n", not the outer scope variable "n".

  - ##### 

- - ##### This is important to understand, but NOT a good practice to do

    - It is confusing for a reason, so best to avoid :)

- A method definition CANNOT access local variables in another scope

- But a method definition can access it if passed as an argument

#### 

#### More on scope

Methods allow us to pass in variables AND blocks to be executed. <https://launchschool.com/lessons/a0f3cd44/assignments/9e9e907c>

- Method definition sets a scope for local variables in terms of parameters and interaction with blocks
- Method invocation uses the scope set by the method definition

#### 

#### Constants

- Constants are said to have lexical scope, which will have more  meaningful consequences when we get to object oriented programming.
- For now, just remember that constants have different scoping rules from local variables.

## 

## 2. Pass by Reference?

##### 

##### TLDR;

##### 

##### When an operation within the method mutates the caller, it will affect the original object.

##### 

##### The background as I understand it:

This is a long debate... but what is the point of the debate? We want to know how passing an object into a method definition can or cannot permanently change the object.

Ruby exhibits a combination of behaviors from both "pass by  reference" as well as "pass by value". Some people call this pass by  reference of the value or call by sharing. Whatever you call it, the  most important concept you should remember is:

##### 

##### When an operation within the method mutates the caller, it will affect the original object.

## 

## 3. Working with Collections

- Know popular collections types: array, hash, string, etc.
- Know popular collection methods: each, map, select, etc.
- Review the two lessons on these topics thoroughly.

#### 

#### Array

- Arrays are ordered, integer-indexed collections of any object.
- <https://launchschool.com/books/ruby/read/arrays>

#### 

#### Hash

- A Hash is a dictionary-like collection of unique keys and their values.
- Also called associative arrays, they are similar to Arrays, but  where an Array uses integers as its index, a Hash allows you to use any  object type.
- <https://launchschool.com/books/ruby/read/hashes>

#### 

#### String

- A String object holds and manipulates an arbitrary sequence of bytes, typically representing characters.

#### 

#### Enumerator Module

- The Enumerable mixin provides collection classes with several traversal and searching methods, and with the ability to sort.

#### 

#### Common Collections Methods

<https://launchschool.com/lessons/85376b6d/assignments/3034b4e0>

| Method | Action         | Considers the return value of the block? | Returns a new collection from the method? | Length of the returned collection |
| ------ | -------------- | ---------------------------------------- | ----------------------------------------- | --------------------------------- |
| each   | Iteration      | No                                       | No, it returns the original               | Length of original                |
| select | Selection      | Yes, its truthiness                      | Yes                                       | Length of original or less        |
| map    | Transformation | Yes                                      | Yes                                       | Length of original                |

##### 

##### Array Methods

- Common methods mentioned for study here: <https://launchschool.com/books/ruby/read/arrays>

##### 

##### Hash Methods

- Common methods mentioned for study here: <https://launchschool.com/books/ruby/read/hashes>

#### 

#### Kramer's Common Methods(#link?)

## 

## 4. Variables as pointers

<https://launchschool.com/books/ruby/read/more_stuff#variables_as_pointers>

The initial takeaway here is to take notice of destructive methods  that mutate the original object vs. methods that just reference an  object.

```
a = "hi there"
b = a
a = "not here"

a = "hi there"
b = a
a << ", Bob"
```

## 

## 5. Puts vs return

<https://launchschool.com/books/ruby/read/methods#putsvsreturnthesequel>

Puts is a method. It returns nil. When a method does something, we often call it a side effect. Methods always return something, even nil.

So when we look at code, we have to be mindful of whether it is doing  some action, (especially a destructive action that causes mutations)  and/or what it is returning after the last line of the block is  evaluated or an explicit return is issued.

## 

## 6. False vs nil and the idea of "truthiness"

- In Ruby only false and nil are falsey.
- Everything else is truthy (yes, even 0 is truthy).

So that it really sinks in…

In Ruby, every value apart from false and nil, evaluates to true in a  boolean context. We can therefore say that in Ruby, every value apart  from false and nil is truthy; we can also say that false and nil are  falsey. This is not the same as saying every value apart from false and  nil is true, or is equal to true. These may seem like subtle  distinctions but they are important ones.

YET ANOTHER NOTE: "Evaluates to true" isn’t the same as the boolean "true"

Use "evaluates to true" or "is truthy" when discussing an expression that evaluates to true in a boolean context Do not use "is true" or "is equal to true" unless specifically discussing the boolean true

## 

## 7. Method definition and method invocation

- Method definition is when, within our code, we define a Ruby method using the def keyword.
- Method invocation is when we call a method, whether that happens to  be an existing method from the Ruby Core API or Standard Library, or a  custom method that we've defined ourselves using the def keyword.

#### 

#### Simpler

- Method definition is simply the act of defining the method in our code using keyword `def`.
- Method invocation is simply calling a method… invoking it.

## 

## 8. Implicit return value of method invocations and blocks

- Methods always return something, even nil. In the case of ruby: 
  - Ruby methods ALWAYS return the evaluated result of the last line of the expression unless an explicit return comes before it.
  - i.e. Return value is implied (implicit) unless otherwise called explicitly, like: `return x`

#### 

#### When answering the questions, you should...

- Reference Line Numbers
- Reference Methods Defined or Invoked
- Reference Variables Are they being: 
  - initialized?
  - assigned?
  - referenced?
- Reference Blocks 
  - where they start and stop?
  - what they are doing?
- Be sure to check each line for multiple instances of any of the above
- Identify the fundamental concept being demonstrated by the question. 
  - what was the point of this question?
  - is this about scoping?
  - something else?

# 

# II. Explaining Code

## 

## 1. Common Computational Language

Know Common Words (nouns, verbs)

- Nouns (objects) 
  - Local Variable
  - Constant
  - Element
  - Key
  - Value
  - Parameter 
    - Methods are defined as parameters
  - Argument 
    - Methods are called as arguments
- Verbs (actions) 
  - Initializes
  - Calls / Invokes
  - Assigns
  - Reassigns
  - References / Points to
  - Defines
  - Iterates
  - Returns
  - Outputs

## 

## 2. What to look for

### 

### a. Anytime you see a local variable

- is it being initialized? 
  - what is being assigned to it?
- is it being reassigned? 
  - what is being reassigned to it?
- what is it referencing?

#### 

#### note:

- parameters appear in method definitions;
- arguments appear in method calls

### 

### b. Anytime you see a method

- is it being defined? 
  - what are the parameters, if any?
- is it being invoked? 
  - what arguments are supplied to the method call, if any? 
    - are we passing in an object as an argument?
    - are we passing in a block as an argument? 
      - does the block argument have a block parameter? 
        - what argument is being passed into the block parameter?
      - does the block mutate something?
      - what does the block return?
- does the method mutate something?
- what does the method return?

### 

### c. Keywords

Operators

WHAT IS ANY BIT OF LANGUAGE THAT WE TYPE? There are only so many keywors right? Variables, Methods, and Keywords... is that everything?

# 

# III. Example Code Explanations

## 

## Example 1

#### 

#### Explain the following code:

```
a = 'hello'
b = a
a = 'goodbye'
```

#### 

#### Explanation

- `line 1` initializes the local variable `a` and assigns the string object `hello` to it
- `line 2` initializes the local variable `b` and assigns the value that `a` references
- `a` and `b` now both reference the string object `hello`
- `line 3` reassigns the string object `goodbye` to the local variable `a`
- `a` now references the string object `goodbye`
- `b` still references the string object `hello`

## 

## Example 2

#### 

#### Explain the following code:

```
def example(str)
  i = 3
  loop do
    puts str
    i -= 1
    break if i == 0
  end
end

example('hello')
```

#### 

#### Explanation

- `lines 1-8` defines the method `example` which takes 1 parameter `str`.

- `line 2` initializes the local variable `i` and assigns the value `3` to it.

- `line 3` calls the `loop` method and passes a block argument to it.

- The 

  ```
  loop
  ```

   method will repeatedly execute the block defined on 

  ```
  lines 3-7
  ```

  - `line 4` calls the `puts` method and passes the `str` argument to it.

  - The `puts` method will output the value referenced by `str`

  - ```
    line 5
    ```

     uses syntactical sugar where 

    ```
    i -= 1
    ```

     is the same as 

    ```
    i = i - 1
    ```

    - So `i` will be reassigned the value evaluated from the expression `i - 1`
    - `i - 1` is the same as `i.-(1)`
    - `i.-(1)` calls the `-` method on `i` and passes in `1` as an argument to it.

  - `line 6` invokes the break method if the conditional statement on `line 6` evaluates to `true`, which in this case is if `i`'s reference value equals `0`.

- In this example, the loop will output `str`'s reference value 3 times because it will take 3 iterations before `i`'s' value is reassigned to `0` causing the break statement to be invoked.

- `line 10` invokes the `example` method and passes to it the string value `"hello"` as an argument.

- Since `str`'s value is output 3 times and `str`'s reference value is the string object `hello`, we know that this example will output the string object `hello` 3 times.

## 

## Example 3

#### 

#### Explain the following code:

```
a = 4

loop do
  a = 5
  b = 3
  break
end

puts a
puts b
```

#### 

#### Explanation

- `line 1` initializes the local variable `a` and assigns the value `4` to it
- `line 3` calls the `loop` method and passes a block to it as an argument
- The `do..end` on `lines 3-7` define this block
- `line 4` reassigns the value `5` to the local variable `a`, since `a` was already initialized in the * outer scope
- `line 5` initializes the local variable `b` within the inner scope and assigns the value `3` to it
- `line 6` calls the `break` method terminates the loop
- `line 8` calls the `puts` method and passes `a` to it as an argument
- Since `a` references the value `5`, `5` is output
- `line 9` calls the `puts` method and passes `b` to it as an argument
- `b` however, is not defined. `b` was never initialized in the outer scope, but rather the inner scope of our loop's block.
- This is an example of variable scoping rules.
- If we had initialized `b` and assigned it to the value `nil` in our outer scope first, then reassignment would have taken place in the loop instead of initialization.
- This is because a variable initialized in the outer scope is  available in the inner scope, but a variable initialized in the inner  scope is not available to the outer scope.

## 

## Example 4

#### 

#### Explain the following code:

```
a = 4
b = 2

loop do
  c = 3
  a = c
  break
end

puts a
puts b
```

#### 

#### Explanation

- `line 1` initializes the local variable `a` and assigns the value `4` to it.

- `line 2` initializes the local variable `b` and assigns the value `2` to it.

- `line 4` invokes the `loop` method and passes a block to it as an argument.

- The 

  ```
  do..end
  ```

   on 

  ```
  lines 4-7
  ```

   defines this block 

  - `line 5` initializes the local variable `c` and assigns the values `3` to it.
  - `line 6` reassigns the value referenced by `c` to `a`
  - Now the value `3` is referenced by `c` and `a`
  - `line 7` calls the `break` method and terminates the loop

- `line 9` calls the '`puts` method and passes `a` to it as an argument

- Since `a` references the value `3`, `3` is output

- `line 10` calls the '`puts` method and passes `b` to it as an argument

- Since `b` still references the value `2`, `2` is output

## 

## Example 5

#### 

#### Explain the following code:

```
a = 4
b = 2

2.times do |a|
  a = 5
  puts a
end

puts a
puts b
```

#### 

#### Explanation

- `line 1` initializes the local variable `a` and assigns the value `4` to it.

- `line 2` initializes the local variable `b` and assigns the value `2` to it.

- `line 4` calls the `times` method on the number `2` and passes a block to it as an argument.

- The 

  ```
  do..end
  ```

   on 

  ```
  lines 4-7
  ```

   defines this block with 

  ```
  a
  ```

   as a parameter 

  - Within the block the local variable `a` initially references the value passed by the block argument.  * NOTE: *the block parameter a takes precedence over the outer scope variable a. This concept is known as variable shadowing*
  - `line 5` reassigns the value `5` to the local variable `a`.
  - NOTE: *again this a is not the same a that points to 4*
  - `line 6` calls the `puts` method and passes the local variable `a` to it as an argument.
  - Since `a` references the value `5` in the inner scope, `5` is output
  - The above block is executed 2 times in total

- `line 9` calls the `puts` method and passes the local variable `a` to it as an argument.

- Since `a` references `4` in the outer block `4` is output.

- `line 9` calls the `puts` method and passes the local variable `a` to it as an argument.

- Since `b` references `2` in the outer block `2` is output.

- So for the example above 5 will be output twice, then 4, then 2

- This example shows variable shadowing

## 

## Example 6

#### 

#### Explain the following code:

```
a = 'hello'

puts a
puts a.object_id

a.upcase!

puts a
puts a.object_id
```

#### 

#### Explanation

`line 1` initializes the local variable `a` and assigns to it the string object `hello` `line 3` calls the `puts` method and passes the local variable `a` to it Since `a` references the string object `hello`, `hello` is output. `line 4` calls the `object_id` method on `a` which returns the object id `a` points to `line 4` calls the `puts` method and passes the returned object id above to it, the object_id is output `line 6` calls the `upcase!` method on the local variable `a`. Since `a` references the string object `hello` and `upcase!` is a destructive method, it will mutate the actual value of `hello` to `HELLO`. `line 8` calls the `puts` method and passes the local variable `a` to it `a` still references the same object, but the object's value is now `HELLO`, so `HELLO` is output `line 9` calls the `object_id` method on `a` which returns the object id `a` points to `line 9` calls the `puts` method and passes the returned object id above to it, the object_id is output The `object_id` method returns the same object id on both `line 4` and on `line 9` when it is invoked.

## 

## Example 7

#### 

#### Explain the following code:

```
a = 'hello'

puts a # -> hello
puts a.object_id # -> 70368468160540 (this number will be different for you)

a.upcase

puts a # -> hello
puts a.object_id  # -> 70368468160540 (this number will be the same as the one above)
```

#### 

#### Explanation

`line 1` initializes the local variable `a` and assigns to it the string object `hello` `line 3` calls the `puts` method and passes the local variable `a` to it Since `a` references the string object `hello`, `hello` is output. `line 4` calls the `object_id` method on `a` which returns the object id `a` points to `line 4` calls the `puts` method and passes the returned object id above to it, the object id is output `line 6` calls the `upcase` method on the local variable `a`. Since `a` references the string object `hello` and `upcase` is a not a destructive method, it will simply return a new string object `HELLO`. The return value is ignored and `a` still references the string object `hello` `line 8` calls the `puts` method and passes the local variable `a` to it `a` still references the same string object `hello`, so `hello` is output `line 9` calls the `object_id` method on `a` which returns the object id `a` points to `line 9` calls the `puts` method and passes the returned object id above to it, the object id is output The `object_id` method returns the same object id for both `line 4` and `line 9` when it is invoked.

## 

## Example 8

#### 

#### Explain the following code:

```
a = 'name'
b = 'name'
c = 'name'

# Are these three local variables pointing to the same object?

puts a.object_id
puts b.object_id
puts c.object_id

# And when we add these two lines of code... ?

a = c
b = a

puts a.object_id
puts b.object_id
puts c.object_id

# What about now?
a = 5
b = 5
c = 5

puts a.object_id
puts b.object_id
puts c.object_id
```

#### 

#### Explanation

## 

## Example 9

#### 

#### Explain the following code:

```
a = :dog
b = :dog
c = :dog

puts a.object_id
puts b.object_id
puts c.object_id
```

#### 

#### Explanation

`line 1` initializes the local variable `a` and assigns the symbol `:dog` to it. `line 2` initializes the local variable `b` and assigns the symbol `:dog` to it. `line 3` initializes the local variable `c` and assigns the symbol `:dog` to it. `a`, `b`, and `c` all reference the same symbol `:dog` at the same place in memory.

`line 5` calls the `object_id` method on the local variable `a` which returns an object id `line 5` calls the `puts` method on the returned object_id, object_id is output

`line 6` calls the `object_id` method on the local variable `b` which returns an object id `line 6` calls the `puts` method on the returned object_id, object_id is output

`line 7` calls the `object_id` method on the local variable `c` which returns an object id `line 7` calls the `puts` method on the returned object_id, object_id is output

All the object id's above are the same because the symbol `:dog` occupies one place in memory and the local variables `a`, `b`, and `c` reference it.

So this will output the same object idea 3 times.

This shows us that symbols occupy the same physical space in memory.

## 

## Understanding Select

- The `select` method is called on an array with a block
- Each element of the array is passed to the block
- If the block's return value *evaluates* to true (so it is truthy), the value itself is returned and is added as an element to a new array `new_array`.
- If the block's return value *evaluates* to false or nil (so it is falsey), the value is ignored. This `new_array` of elements (if any) are returned by select.

Here is a good example with a break down:

```
[false,nil,true,0,1,"","0","1",2+2,2+2==4,2+3,2+3 == 4].select{ |e| e }
```

What will the above return?

Each array element is in the table below. Here is what select does when called on the array with the given block `{ |e| e }`.

| element  | value | truthy / falsey | in new_array? | element in new_array |
| -------- | ----- | --------------- | ------------- | -------------------- |
| false    | false | falsey          | nope          | n/a                  |
| nil      | nil   | falsey          | nope          | n/a                  |
| true     | true  | truthy          | YES           | true                 |
| 0        | 0     | truthy          | YES           | 0                    |
| 1        | 1     | truthy          | YES           | 1                    |
| ""       | ""    | truthy          | YES           | ""                   |
| "0"      | "0"   | truthy          | YES           | "0"                  |
| "1"      | "1"   | truthy          | YES           | "1"                  |
| 2+2      | 4     | truthy          | YES           | 4                    |
| 2+2 == 4 | true  | truthy          | YES           | true                 |
| 2+3      | 5     | truthy          | YES           | 5                    |
| 2+3 == 4 | false | falsey          | nope          | n/a                  |

The return of select called on the above array:

```
[true, 0, 1, "", "0", "1", 4, true, 5]
```

Add this somewhere... pointers?

Integers and symbols in Ruby with same values occupy the same  physical space in memory(they are the same objects) so integer 4 will  always be the same object with same object_id even though you assign it  to different local variables. Same goes with symbols :

#### 

#### For written assessment

- Watch beginner webinar series? <https://launchschool.com/blog/live-session-beginning-ruby> Specifically 1,2,3
- Iterate over an array of numbers, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], and print out each value utilizing both loop and iteration

```
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

i = 0
loop do
  puts arr[i]
  i += 1
  break if i == arr.size
end

arr.each do |num|
  puts num
end
```

#### 

#### `loop` returns `nil` and `each` returns the original array `arr`

- Same as above, except print out the number only if the value is greater than 5
- append 12 to end of array
- prepend 0 to beginning of array
- remove the 12, and append a 3
- remove duplicates using 1 method
- extract all odd numbers into a new array (selection)
- increment all numbers by 1 (Transformation - new vs mutation)
- fine sum of all numbers
- Read Srdjan's 4 part series <https://medium.com/how-i-started-learning-coding-from-scratch/advices-for-109-written-assessment-part-1-6f7fa821cf84>

#### 

#### For live code review

- Practice in coder pad so you know what it's like
- Watch other people's code videos
- Code aloud