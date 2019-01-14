## Question 1

What do you expect to happen when the `greeting` variable is referenced in the last line of the code below?

```ruby
if false
  greeting = “hello world”
end

greeting
```

### My answer

I got it wrong.

### LA answer

`greeting` is `nil` here, and no "undefined method or local variable" exception is thrown. Typically, when you reference an uninitialized variable, Ruby will raise an exception, stating that it’s undefined. However, when you initialize a local variable within an `if` block, even if that `if` block doesn’t get executed, the local variable is initialized to `nil`.



## Question 2

What is the result of the last line in the code below?

```ruby
greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << ' there'

puts informal_greeting  #  => "hi there"
puts greetings
```

### My answer

I got it wrong.

### LA answer

The output is `{:a=>"hi there"}`. The reason is because `informal_greeting` is a reference to the original object. The line `informal_greeting << ' there'` was using the `String#<<` method, which modifies the object that called it. This means that the original object was changed, thereby impacting the value in `greetings`. If instead of modifying the original object, we wanted to only modify `informal_greeting` but not `greetings`, there are a couple of options:

- we could initialize `informal_greeting` with a reference to a new object containing the same value by `informal_greeting = greetings[:a].clone`.
- we can use string concatenation, `informal_greeting = informal_greeting + ' there'`, which returns a new `String` object instead of modifying the original object.



## Question 3

In other practice problems, we have looked at how the scope of variables affects the modification of one "layer" when they are passed to another.

To drive home the salient aspects of variable scope and modification of one scope by another, consider the following similar sets of code.

What will be printed by each of these code groups?

A)

```ruby
def mess_with_vars(one, two, three)
  one = two
  two = three
  three = one
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"
```

B)

```ruby
def mess_with_vars(one, two, three)
  one = "two"
  two = "three"
  three = "one"
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"
```

C)

```ruby
def mess_with_vars(one, two, three)
  one.gsub!("one","two")
  two.gsub!("two","three")
  three.gsub!("three","one")
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"
```

### My answer

In methods described in A) and B) the method reassign variables in the method scope. This has no consequence for the original object. As such the output for both of them are:

```ruby
puts "one is: one"
puts "two is: two"
puts "three is:three"
```

For the method in C), variable that are passed in arguments will be subjected to a mutating operation the `#gsub!`. This method will not create new objects but will alter values that bound to these variables.

The out puts will be:

```ruby
puts "one is: two"
puts "two is: three"
puts "three is: one"
```



## Question 4

Ben was tasked to write a simple ruby method to determine if an input string is an IP address representing dot-separated numbers. e.g. "10.4.5.11". He is not familiar with regular expressions. Alyssa supplied Ben with a method called `is_an_ip_number?` that determines if a string is a numeric string between `0` and `255` as required for IP numbers and asked Ben to use it.

```ruby
def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    break unless is_an_ip_number?(word)
  end
  return true
end
```

Alyssa reviewed Ben's code and says "It's a good start, but you missed a few things. You're not returning a false condition, and you're not handling the case that there are more or fewer than 4 components to the IP address (e.g. "4.5.5" or "1.2.3.4.5" should be invalid)."

Help Ben fix his code.

### My solution

```ruby
def is_an_ip_number?(word)
  (0..255).cover?(word.to_i)
end

def dot_separated_words_valid_size?(input_array)
input_array.size !=4 ? false : true
end

def validation_word_from_input(input_string)
dot_separated_words = input_string.split(".")
  if dot_separated_words_valid_size?(dot_separated_words)
    while dot_separated_words.size > 0
      word = dot_separated_words.shift
      break unless is_an_ip_number?(word)
    end
      if dot_separated_words.size == 0
        puts true
      else
        puts false
      end
  else
    puts false
  end
end

validation_word_from_input('11.11.134.12.23')
validation_word_from_input('11.345.134.12')
validation_word_from_input('11.222.134.12')

```

