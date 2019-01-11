### Question 1

What would you expect the code below to print out?

```ruby
numbers = [1, 2, 2, 3]
numbers.uniq

puts numbers
```

#### My answer

The method `#uniq` eliminates duplicates in an array. However the method `#uniq` does not mutate the caller. Consequently when using `puts` will also output duplicates. One particularity though, is that, `puts` will not output an array but will display each element of the array by line. 



### Question 2

Describe the difference between `!` and `?` in Ruby. And explain what would happen in the following scenarios:

1. what is `!=` and where should you use it?
2. put `!` before something, like `!user_name`
3. put `!` after something, like `words.uniq!`
4. put `?` before something
5. put `?` after something
6. put `!!` before something, like `!!user_name`

#### My answer

1. `!=` means "not equals to". We can use it in conditionals. 

   ```ruby  
   # Example
   
   n = 0
   
   while n != 5
       n += 1
       p n
   end
   ```

2. Putting `!` before something evaluates to false

3. `!` We cannot ascertain the function of `!` after something. In some case it is associated with mutating methods

4. Using `?` before something transforms it into a string object. 

5. We can use `?` in ternary conditions:

   ```ruby
   # Example
   2 > 3 ? true : false
   ```

   In some methods having the `?` may also means that the method assesses the truthfulness. But it is not a general rule.

6. Putting `!` before something evaluates this to false. Putting an additional `!` will revert it and evaluates to true. 

#### LA answer

Just to clarify, if you see `!` or `?` at the end of the method, it's actually part of the method name, and not Ruby syntax. Therefore, you really don't know what the method is doing, even if it ends in those characters -- it depends on the method implementation. The other uses are actual Ruby syntax:

- `!=` means "not equals"
- `? :` is the ternary operator for if...else
- `!!<some object>` is used to turn any object into their boolean equivalent. (Try it in irb)
- `!<some object>` is used to turn any object into the opposite of their boolean equivalent, just like the above, but opposite.



### Question 3

Replace the word "important" with "urgent" in this string:

```ruby
advice = "Few things in life are as important as house training your pet dinosaur."
```

#### My answer

```ruby
#Brute force
array = advice.split('')
array[6] = 'urgent'
advice = arr.join(' ')

#Ruby style
advice.gsub('important', 'urgent')
```



### Question 4

The Ruby Array class has several methods for removing items from the array. Two of them have very similar names. Let's see how they differ:

```ruby
numbers = [1, 2, 3, 4, 5]
```

What do the following method calls do (assume we reset `numbers` to the original array between method calls)?

```ruby
numbers.delete_at(1)
numbers.delete(1)
```

#### My answer

```ruby
numbers.delete_at(1) # Delete the element present at index 1.
numbers.delete(1) # Delete the element 1
```



### Question 5

Programmatically determine if 42 lies between 10 and 100.

*hint: Use Ruby's range object in your solution.*

#### My answer

```ruby
(10..100).cover?(42)
```



### Question 6

Starting with the string:

```ruby
famous_words = "seven years ago..."
```

show two different ways to put the expected "Four score and " in front of it.

#### My answer

```ruby
#1
famous_words.prepend("Four score and ")

#2
"Four score and" << " " << famous_words

#3
famous_words.split(" ").unshift("Four score and".split(" ")).join(" ")
```

#### LA answer

```ruby
"Four score and " + famous_words
```

or

```ruby
famous_words.prepend("Four score and ")
```

or

```ruby
"Four score and " << famous_words
```



### Question 7

Fun with gsub:

```ruby
def add_eight(number)
  number + 8
end

number = 2

how_deep = "number"
5.times { how_deep.gsub!("number", "add_eight(number)") }

p how_deep
```

This gives us a string that looks like a "recursive" method call:

```ruby
"add_eight(add_eight(add_eight(add_eight(add_eight(number)))))"
```

If we take advantage of Ruby's `Kernel#eval` method to have it execute this string as if it *were* a "recursive" method call

```ruby
eval(how_deep)
```

what will be the result?

#### My answer

I cannot answer intuitively. The description of the method is a bit autistic. But by running this code:

```ruby
def add_eight(number)
  number + 8
end

number = 2

how_deep = "number"
5.times { how_deep.gsub!("number", "add_eight(number)") }

eval(how_deep)
p how_deep
```

`eval(how_deep)` returns `42`. 

Somehow `eval(how_deep)` == number the value being 2

```ruby
5.times { how_deep.gsub!("number", "add_eight(number)") }
```

This piece of code mutate the caller. We will have five times the replacement of the string number by the string "add_eight(number)" where the parameters `number` is itself replaced by add_eight(number). 

If we call eval(how_deep) he somehow consider "number" and "add_eight(number)" as data, meaning that `Kernel.eval()` does not consider `"number"` as a string object but as `number = 2`. Similarly it does not consider `"add_eight(number)"` as a string but rather as the method `add_eight(number)`. 

As this recursive `eval(how_deep)` will literally do the following:

```ruby
add_eight(add_eight(add_eight(add_eight(add_eight(2))))) # => 8 + 8 + 8 + 8 + 8 + 2
```

#### LA answer

```none
42
```

Note: The `Kernel#eval` method is a rarely used Ruby method. You're not expected to understand how it works at this stage.



### Question 8

If we build an array like this:

```ruby
flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]
```

We will end up with this "nested" array:

```ruby
["Fred", "Wilma", ["Barney", "Betty"], ["BamBam", "Pebbles"]]
```

Make this into an un-nested array.

#### My answer

```ruby
flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]
```



### Question 9

Given the hash below

```ruby
flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }
```

Turn this into an array containing only two elements: Barney's name and Barney's number

#### My answer

```ruby
[] << flintstones.key(2) << flintstones["Barney"]
```

#### LA answer

```ruby
flintstones.assoc("Barney")
```









