## Question 1

Every named entity in Ruby has an `object_id`. This is a unique identifier for that object.

It is often the case that two different things "look the same", but they can be different objects. The "under the hood" object referred to by a particular named-variable can change depending on what is done to that named-variable.

In other words, in Ruby everything is an object...but it is not always THE SAME object.

Predict how the values and object ids will change throughout the flow of the code below:

```ruby
def fun_with_ids
  a_outer = 42
  b_outer = "forty two"
  c_outer = [42]
  d_outer = c_outer[0]

  a_outer_id = a_outer.object_id
  b_outer_id = b_outer.object_id
  c_outer_id = c_outer.object_id
  d_outer_id = d_outer.object_id

  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} before the block."
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} before the block."
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} before the block."
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} before the block.

"

  1.times do
    a_outer_inner_id = a_outer.object_id
    b_outer_inner_id = b_outer.object_id
    c_outer_inner_id = c_outer.object_id
    d_outer_inner_id = d_outer.object_id

    puts "a_outer id was #{a_outer_id} before the block and is: #{a_outer_inner_id} inside the block."
    puts "b_outer id was #{b_outer_id} before the block and is: #{b_outer_inner_id} inside the block."
    puts "c_outer id was #{c_outer_id} before the block and is: #{c_outer_inner_id} inside the block."
    puts "d_outer id was #{d_outer_id} before the block and is: #{d_outer_inner_id} inside the block.

"

    a_outer = 22
    b_outer = "thirty three"
    c_outer = [44]
    d_outer = c_outer[0]

    puts "a_outer inside after reassignment is #{a_outer} with an id of: #{a_outer_id} before and: #{a_outer.object_id} after."
    puts "b_outer inside after reassignment is #{b_outer} with an id of: #{b_outer_id} before and: #{b_outer.object_id} after."
    puts "c_outer inside after reassignment is #{c_outer} with an id of: #{c_outer_id} before and: #{c_outer.object_id} after."
    puts "d_outer inside after reassignment is #{d_outer} with an id of: #{d_outer_id} before and: #{d_outer.object_id} after.

"


    a_inner = a_outer
    b_inner = b_outer
    c_inner = c_outer
    d_inner = c_inner[0]

    a_inner_id = a_inner.object_id
    b_inner_id = b_inner.object_id
    c_inner_id = c_inner.object_id
    d_inner_id = d_inner.object_id

    puts "a_inner is #{a_inner} with an id of: #{a_inner_id} inside the block (compared to #{a_outer.object_id} for outer)."
    puts "b_inner is #{b_inner} with an id of: #{b_inner_id} inside the block (compared to #{b_outer.object_id} for outer)."
    puts "c_inner is #{c_inner} with an id of: #{c_inner_id} inside the block (compared to #{c_outer.object_id} for outer)."
    puts "d_inner is #{d_inner} with an id of: #{d_inner_id} inside the block (compared to #{d_outer.object_id} for outer).

"
  end

  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} BEFORE and: #{a_outer.object_id} AFTER the block."
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} BEFORE and: #{b_outer.object_id} AFTER the block."
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} BEFORE and: #{c_outer.object_id} AFTER the block."
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} BEFORE and: #{d_outer.object_id} AFTER the block.

"

  puts "a_inner is #{a_inner} with an id of: #{a_inner_id} INSIDE and: #{a_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
  puts "b_inner is #{b_inner} with an id of: #{b_inner_id} INSIDE and: #{b_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
  puts "c_inner is #{c_inner} with an id of: #{c_inner_id} INSIDE and: #{c_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
  puts "d_inner is #{d_inner} with an id of: #{d_inner_id} INSIDE and: #{d_inner.object_id} AFTER the block.

" rescue puts "ugh ohhhhh"
end
```

### My answer

```ruby
a_outer is 42 with an id of: 85 before the block.
b_outer is forty two with an id of: 46963849813240 before the block.
c_outer is [42] with an id of: 46963849813220 before the block.
d_outer is 42 with an id of: 85 before the block.  
```

Each object has defined id. Note that an integer `n` have a fixed object_id =`(n + (n+1))`.

```rub
a_outer id was 85 before the block and is: 85 inside the block.
b_outer id was 46963849813240 before the block and is: 46963849813240 inside the block.
c_outer id was 46963849813220 before the block and is: 46963849813220 inside the block.
d_outer id was 85 before the block and is: 85 inside the block.
```

Object_ids are similar.

```ruby
a_outer inside after reassignment is 22 with an id of: 85 before and: 45 after.
b_outer inside after reassignment is thirty three with an id of: 46963849813240 before and: 46963849810140 after.
c_outer inside after reassignment is [44] with an id of: 46963849813220 before and: 46963849809920 after.
d_outer inside after reassignment is 44 with an id of: 85 before and: 89 after.
```

Reassignment makes the same variables pointing to different object that harbor different object_id than before.

```ruby
a_inner is 22 with an id of: 45 inside the block (compared to 45 for outer).
b_inner is thirty three with an id of: 46963849810140 inside the block (compared to 46963849810140 for outer).
c_inner is [44] with an id of: 46963849809920 inside the block (compared to 46963849809920 for outer).
d_inner is 44 with an id of: 89 inside the block (compared to 89 for outer).
```

Nothing changes

```ruby
a_outer is 22 with an id of: 85 BEFORE and: 45 AFTER the block.
b_outer is thirty three with an id of: 46963849813240 BEFORE and: 46963849810140 AFTER the block.
c_outer is [44] with an id of: 46963849813220 BEFORE and: 46963849809920 AFTER the block.
d_outer is 44 with an id of: 85 BEFORE and: 89 AFTER the block.def fun_with_ids
```

At the end reassignment made the same variables pointing to different object that harbor different object_id than before.



## Question 2

Let's look at object id's again from the perspective of a method call instead of a block.

Here we haven't changed ANY of the code outside or inside of the block/method. We simply took the contents of the block from the previous practice problem and moved it to a method, to which we are passing all of our outer variables.

Predict how the values and object ids will change throughout the flow of the code below:

```ruby
def fun_with_ids
  a_outer = 42
  b_outer = "forty two"
  c_outer = [42]
  d_outer = c_outer[0]

  a_outer_id = a_outer.object_id
  b_outer_id = b_outer.object_id
  c_outer_id = c_outer.object_id
  d_outer_id = d_outer.object_id

  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} before the block."
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} before the block."
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} before the block."
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} before the block.

"

  an_illustrative_method(a_outer, b_outer, c_outer, d_outer, a_outer_id, b_outer_id, c_outer_id, d_outer_id)


  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} BEFORE and: #{a_outer.object_id} AFTER the method call."
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} BEFORE and: #{b_outer.object_id} AFTER the method call."
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} BEFORE and: #{c_outer.object_id} AFTER the method call."
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} BEFORE and: #{d_outer.object_id} AFTER the method call.

"

  puts "a_inner is #{a_inner} with an id of: #{a_inner_id} INSIDE and: #{a_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
  puts "b_inner is #{b_inner} with an id of: #{b_inner_id} INSIDE and: #{b_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
  puts "c_inner is #{c_inner} with an id of: #{c_inner_id} INSIDE and: #{c_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
  puts "d_inner is #{d_inner} with an id of: #{d_inner_id} INSIDE and: #{d_inner.object_id} AFTER the method.

" rescue puts "ugh ohhhhh"
end


def an_illustrative_method(a_outer, b_outer, c_outer, d_outer, a_outer_id, b_outer_id, c_outer_id, d_outer_id)
  a_outer_inner_id = a_outer.object_id
  b_outer_inner_id = b_outer.object_id
  c_outer_inner_id = c_outer.object_id
  d_outer_inner_id = d_outer.object_id

  puts "a_outer id was #{a_outer_id} before the method and is: #{a_outer.object_id} inside the method."
  puts "b_outer id was #{b_outer_id} before the method and is: #{b_outer.object_id} inside the method."
  puts "c_outer id was #{c_outer_id} before the method and is: #{c_outer.object_id} inside the method."
  puts "d_outer id was #{d_outer_id} before the method and is: #{d_outer.object_id} inside the method.

"

  a_outer = 22
  b_outer = "thirty three"
  c_outer = [44]
  d_outer = c_outer[0]

  puts "a_outer inside after reassignment is #{a_outer} with an id of: #{a_outer_id} before and: #{a_outer.object_id} after."
  puts "b_outer inside after reassignment is #{b_outer} with an id of: #{b_outer_id} before and: #{b_outer.object_id} after."
  puts "c_outer inside after reassignment is #{c_outer} with an id of: #{c_outer_id} before and: #{c_outer.object_id} after."
  puts "d_outer inside after reassignment is #{d_outer} with an id of: #{d_outer_id} before and: #{d_outer.object_id} after.

"


  a_inner = a_outer
  b_inner = b_outer
  c_inner = c_outer
  d_inner = c_inner[0]

  a_inner_id = a_inner.object_id
  b_inner_id = b_inner.object_id
  c_inner_id = c_inner.object_id
  d_inner_id = d_inner.object_id

  puts "a_inner is #{a_inner} with an id of: #{a_inner_id} inside the method (compared to #{a_outer.object_id} for outer)."
  puts "b_inner is #{b_inner} with an id of: #{b_inner_id} inside the method (compared to #{b_outer.object_id} for outer)."
  puts "c_inner is #{c_inner} with an id of: #{c_inner_id} inside the method (compared to #{c_outer.object_id} for outer)."
  puts "d_inner is #{d_inner} with an id of: #{d_inner_id} inside the method (compared to #{d_outer.object_id} for outer).

"
end
```

### LA answer

```none
a_outer is 42 with an id of: 85 before the block.
b_outer is forty two with an id of: 2152753560 before the block.
c_outer is [42] with an id of: 2152753540 before the block.
d_outer is 42 with an id of: 85 before the block.
```

Notice that this works the same as before. No big surprise.

```none
a_outer id was 85 before the method and is: 85 inside the method.
b_outer id was 2152753560 before the method and is: 2152753560 inside the method.
c_outer id was 2152753540 before the method and is: 2152753540 inside the method.
d_outer id was 85 before the method and is: 85 inside the method.
```

This is also the same as before. These "outers" are NOT the same variables as those outside, Ruby is simply re-using the objects, as these new variables have the same values as the ones outside.

```none
a_outer inside after reassignment is 22 with an id of: 85 before and: 45 after.
b_outer inside after reassignment is thirty three with an id of: 2152753560 before and: 2152752300 after.
c_outer inside after reassignment is [44] with an id of: 2152753540 before and: 2152752280 after.
d_outer inside after reassignment is 44 with an id of: 85 before and: 89 after.
```

As before with the block version of this practice problem, when we change the values of our "outers", Ruby uses new objects for these variables to deal with their new values.

One important difference to note is that before, we saw Ruby re-using the "42" object and just giving it a new value inside the block. Why the difference? It should become clear a couple of paragraphs later in this solution...

```none
a_inner is 22 with an id of: 45 inside the method (compared to 45 for outer).
b_inner is thirty three with an id of: 2152752300 inside the method (compared to 2152752300 for outer).
c_inner is [44] with an id of: 2152752280 inside the method (compared to 2152752280 for outer).
d_inner is 44 with an id of: 89 inside the method (compared to 89 for outer).
```

No big surprise here...Ruby is re-using objects that have the same values...

```none
a_outer is 42 with an id of: 85 BEFORE and: 85 AFTER the method call.
b_outer is forty two with an id of: 2152753560 BEFORE and: 2152753560 AFTER the method call.
c_outer is [42] with an id of: 2152753540 BEFORE and: 2152753540 AFTER the method call.
d_outer is 42 with an id of: 85 BEFORE and: 85 AFTER the method call.
```

Wow, look at that. Even though we changed the values of our "outer" variables inside the method call, we still have the same values and the same object id's down here AFTER the method call as we had before it!

This is because our method call accepts VALUES as parameters. The names we give to those values in the definition of our method are SEPARATE from any other use of those same names.

We used the same names there for convenience (and admittedly to build some suspense and allow us to clarify this point). We could just as easily have called the first parameter of our method definition `a_Fred` instead of `a_outer`.

The method gets the VALUES of the parameters we pass, but the parameter variables inside the method have no other relationship to those outside of the method. The names were coincidental, and confusing in a useful way.

```none
=> "ugh ohhhhh"
```

Our main method STILL has no access to variables that are defined inside of the method.



## Question 3

Let's call a method, and pass both a string and an array as parameters and see how even though they are treated in the same way by Ruby, the results can be different.

Study the following code and state what will be displayed...and why:

```ruby
def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param << "rutabaga"
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"
```

### My answer

The output will be the following:

```ruby
puts "My string looks like this now: pumkins"
puts "My array looks like this now: ["pumpkins", "rutabaga"]"
```

The argument my_array will be subjected to a mutating method: the method `#<<`. Consequently passing `my_array` in the `tricky method` will change the value of the variable. In the case of the string, we can see that the method reassign the argument to a new variable that has the same name (variable shadowing). Nevertheless reassignment create a new object that will be then modified accordingly. if we were doing something like this:

```ruby
def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param << "rutabaga"
    puts a_string_param
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

```

The output would be:

```ruby
pumpkinsrutabaga # We can see here the method creates a new object with a new value 				   whitout affecting the original object.

My string looks like this now: pumpkins
My array looks like this now: ["pumpkins", "rutabaga"]
```

### LA answer

Our output will look like this:

```none
My string looks like this now: pumpkins
My array looks like this now: ["pumpkins", "rutabaga"]
```

Why? It seems clear from the above that Ruby treats string and array parameters differently...but not so fast. Actually the parameters are treated in exactly the same way...but the results are different.

In both cases, Ruby passes the parameter "by value", but unlike some other languages, the value that gets passed is a reference to some object. The string parameter is passed to the method as a reference to an object of type String. Similarly, the array is passed to the method as a reference to an object of type Array.

The important distinction is that while a reference is passed, the method initializes a new local variable for both the string and the array and assigns each reference to the new local variables. These are variables that only live within the scope of the method definition.

So if both parameters live inside the method as a new variable that stores a reference to the passed object...why don't the string and the array behave the same way in our output?

The difference lies in what Ruby does when the program executes either a `String#+=` operation or an `Array#<<` operation.

The `String#+=` operation is re-assignment and **creates a new String object**. The reference to this new object is assigned to `a_string_param`. The local variable `a_string_param` now points to `"pumpkinsrutabaga"`, not `"pumpkins"`. It has been re-assigned by the `String#+=` operation. This means that `a_string_param` and `my_string` no longer point to the same object.

With the array, one array object can have any number of elements. When we attach an additional element to an array using the `<<` operator, Ruby simply keeps using the same object that was passed in, and appends the new element to it.

So, because the local variable `an_array_param` still points to the original object, the local variables `my_array` and `an_array_param`are still pointing at the same object, and we see the results of what happened to the array "outside" of the method.



## Question 4

To drive that last one home...let's turn the tables and have the string show a modified output, while the array thwarts the method's efforts to modify the caller's version of it.

```ruby
def tricky_method_two(a_string_param, an_array_param)
  a_string_param << 'rutabaga'
  an_array_param = ['pumpkins', 'rutabaga']
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method_two(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"
```

### My answer

The output is:

```ruby
My string looks like this now: pumpkinsrutabaga
My array looks like this now: ["pumpkins"]
```

In this method now the string is subjected to a mutating operation. And the array binds a new value inside the method. Consequently the method will modify the value of `my_string` but not the one bound to the outer scope `my_array`.



## Question 5

How could the unnecessary duplication in this method be removed?

```ruby
def color_valid(color)
  if color == "blue" || color == "green"
    true
  else
    false
  end
end
```

### My answer

We can re-write the method as followed:

```ruby
def color_valid?(color)
  color == "blue" || color == "green"
end
```

The operator `||` allows us to evaluate `blue` or `green` to true. Any other color passed as a string argument will return false.



