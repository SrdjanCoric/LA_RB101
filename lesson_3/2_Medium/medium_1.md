## Question 1

Let's do some "ASCII Art" (a stone-age form of nerd artwork from back in the days before computers had video screens).

For this practice problem, write a one-line program that creates the following output 10 times, with the subsequent line indented 1 space to the right:

```none
The Flintstones Rock!
 The Flintstones Rock!
  The Flintstones Rock!
```

### My solution

```ruby
10.times { |n| puts ' ' * n + 'The Flintstones Rock!' }
```



## Question 2

The result of the following statement will be an error:

```ruby
puts "the value of 40 + 2 is " + (40 + 2)
```

Why is this and what are two possible ways to fix this?

### My solution

In this situation we are adding an integer to a string which is impossible here. We will have a error saying something like no implicit conversion of an Integer into a string. To circumvent this problem we can use `#to_s` method or string interpolation. 

```ruby
puts "the value of 40 + 2 is " + (40 + 2).to_s
puts "the value of 40 + 2 is " + "#{(40 + 2)}"
```



## Question 3

Alan wrote the following method, which was intended to show all of the factors of the input number:

```ruby
def factors(number)
  divisor = number
  factors = []
  begin
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end until divisor == 0
  factors
end
```

Alyssa noticed that this will fail if the input is `0`, or a negative number, and asked Alan to change the loop. How can you make this work without using `begin`/`end`/`until`? Note that we're not looking to find the factors for 0 or negative numbers, but we just want to handle it gracefully instead of raising an exception or going into an infinite loop.

#### Bonus 1

What is the purpose of the `number % divisor == 0` ?

#### Bonus 2

What is the purpose of the second-to-last line (`line 8`) in the method (the `factors` before the method's `end`)?

### My solution

Here I propose the following. Because 0 and negative numbers cannot be used here we can st limit and ask to find divisors of a number in a Range where number is the limit.

```ruby
def factors(number)
  factors = []
  for i in (1..number)
    factors << number / i if number % i == 0
  end
  factors
end
```

#### Answer Bonus 1

This line the condition to find the factors. A number x is a factor  of a number y only if y divided by x has no remainder (remainder = 0). So this line set this condition

#### Answer Bonus 2

Putting `factors` allows the method to return the value of factors after all numbers has been pushed in the array.

### LA_Solution

```ruby
def factors(number)
while divisor > 0 do
  factors << number / divisor if number % divisor == 0
  divisor -= 1
end
  factors
end
```



## Question 4

Alyssa was asked to write an implementation of a rolling buffer. Elements are added to the rolling buffer and if the buffer becomes full, then new elements that are added will displace the oldest elements in the buffer.

She wrote two implementations saying, "Take your pick. Do you like `<<` or `+` for modifying the buffer?". Is there a difference between the two, other than what operator she chose to use to add an element to the buffer?

```ruby
def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size > max_buffer_size
  buffer
end
```

### My solution

In the first method. Buffer is passed as an argument and then subjected to a push `#<<` and `#shift` methods that are going to mutate the caller. Consequently in a scope outside of the method, buffer will be modified. Let's take an example:

```ruby
def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

buffer = [1, 2, 3]
puts buffer # before the method => [1, 2, 3]
rolling_buffer1(buffer, 3, 8)
puts buffer # after the method => [2, 3, 8]
```

In the second case argument that is passed are `input_array`, `max_buffer_size` and `new_element`. input

```ruby
buffer = input_array + [new_element]
```

Inside the method input_array + new_element is assigned to buffer. Consequently whatever happened to buffer will not impact the object bound to input_array:

```ruby
def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + new_element
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

input_array = [1, 2, 3]
puts input_array # before the method => [1, 2, 3]
rolling_buffer2(input_array, 1, 8)
puts input_array # after the method => [1, 3, 3]
```

Choosing one of the other will impact on how we want to interfere with our variables that are passed in the methods. 

## Question 5

Alyssa asked Ben to write up a basic implementation of a Fibonacci calculator, A user passes in two numbers, and the calculator will keep computing the sequence until some limit is reached.

Ben coded up this implementation but complained that as soon as he ran it, he got an error. Something about the limit variable. What's wrong with the code?

```ruby
limit = 15

def fib(first_num, second_num)
  while first_num + second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1)
puts "result is #{result}"
```

How would you fix this so that it works?

### My solution

The variable limit is not accessible here in the scope of the method. We can easily fix it by putting the limit as a parameter of the method. 

```ruby
def fib(first_num, second_num, limit)
  while first_num + second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1, 15)
puts "result is #{result}"
```



## Question 6 

In an earlier practice problem we saw that depending on variables to be modified by called methods can be tricky:

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

We learned that whether the above "coincidentally" does what we think we wanted "depends" upon what is going on inside the method.

How can we refactor this practice problem to make the result easier to predict and easier for the next programmer to maintain?

### My solution

Here the tricky part comes from the name w give to the variable. In the method we are using re-assignment and a method that mutate the caller. For the second one it is easy to anticipate on what is going on. For the first one it is more tricky.

Indeed the name of the variable that is used for re-assignment is the same name as the argument. It is a situation of variable shadowing. To avoid this complexity we could just name the variable differently. 

Here let's decompose the re-assignement

```ruby
def tricky_method(a_string_param, an_array_param)
  a_string_param = a_string_param + "rutabaga"
  an_array_param << "rutabaga"
end
```

```ruby
my_string = "pumpkins"
my_array = ["pumpkins"]


tricky_method(my_string, my_array) # When passing my_string to the method this is what happens inside the method

my_string = my_string + "rutabaga" 
my_array << "rutabaga"
```

While it looks counterintuitive the new variable my_string points to a completely different object that is a string with a value `"pumpkinsrutabaga"`. However The original variable my_string available in a outer scope still points to "pumpkins". Consequently:

```ruby
puts "My string looks like this now: #{my_string}" # "My string looks like this now: "pumkins"
puts "My array looks like this now: #{my_array}" # "My array looks like this now: ["pumpkins", "rutabaga"]
```

### My answer is wrong

**It's usually better to implement methods that don't perform destructive actions. That's why the exercise's solution implements a non-destructive approach. Your destructive solution could work, but in that case, you would want all of the actions within the method definition to be destructive, otherwise it's difficult to keep track of which statements are destructive and which ones aren't. Remember methods should be designed to do one thing !**

### LA solution

```ruby
def not_so_tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param += ["rutabaga"]

  return a_string_param, an_array_param
end

my_string = "pumpkins"
my_array = ["pumpkins"]
my_string, my_array = not_so_tricky_method(my_string, my_array) 

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"
```



## Question 7

What is the output of the following code?

```ruby
answer = 42

def mess_with_it(some_number)
  some_number += 8
end

new_answer = mess_with_it(answer)

p answer - 8
```

### My solution

Assignment does not mutate the caller. Here the code will output `34`



## Question 8

One day Spot was playing with the Munster family's home computer and he wrote a small program to mess with their demographic data:

```ruby
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

def mess_with_demographics(demo_hash)
  demo_hash.values.each do |family_member|
    family_member["age"] += 42
    family_member["gender"] = "other"
  end
end
```

After writing this method, he typed the following...and before Grandpa could stop him, he hit the Enter key with his tail:

```ruby
mess_with_demographics(munsters)
```

Did the family's data get ransacked? Why or why not?

### My solution

The variable `munsters` points to an object that is an hash. It is a collection of stored pairs of key & values. Each key points to a specific object. Each value points to a specific object. for example the key `"age"` points to an object that is string with the value `"age"` . The corresponding value points to an integer that has a value of `32`. 

When we do:

```ruby
family_member["age"] += 42
family_member["gender"] = "other"
```

While we are not modifying the hash that still point to the same object, the values elements are re-assigned to new objects. Consequently while applying the method values in the hash will be modified: 

```ruby
mess_with_demographics(munsters)

munsters = {
  "Herman" => { "age" => 74, "gender" => "other" },
  "Lily" => { "age" => 72, "gender" => "other" },
  "Grandpa" => { "age" => 444, "gender" => "other" },
  "Eddie" => { "age" => 52, "gender" => "other" },
  "Marilyn" => { "age" => 65, "gender" => "other"}
}
```



## Question 9

Method calls can take expressions as arguments. Suppose we define a method called `rps` as follows, which follows the classic rules of rock-paper-scissors game, but with a slight twist that it declares whatever hand was used in the tie as the result of that tie.

```ruby
def rps(fist1, fist2)
  if fist1 == "rock"
    (fist2 == "paper") ? "paper" : "rock"
  elsif fist1 == "paper"
    (fist2 == "scissors") ? "scissors" : "paper"
  else
    (fist2 == "rock") ? "rock" : "scissors"
  end
end
```

What is the result of the following call?

```ruby
puts rps(rps(rps("rock", "paper"), rps("rock", "scissors")), "rock")
```

### My Solution

```ruby
paper
```



## Question 10

Consider these two simple methods:

```ruby
def foo(param = "no")
  "yes"
end

def bar(param = "no")
  param == "no" ? "yes" : "no"
end
```

What would be the return value of the following method invocation?

```ruby
bar(foo)
```

### My solution 

The `foo` method returns `'yes'`. The `bar` method also returns yes. Consequently passing the foo method as an argument is equivalent to pass `'yes'`then it becomes 'yes' == 'no' which will return 'no' here 