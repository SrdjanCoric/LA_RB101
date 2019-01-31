## Problem 1

Given the array below

```ruby
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
```

Turn this array into a hash where the names are the keys and the values are the positions in the array.

### My solutions

```ruby
hash_flintstones = {}
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

flintstones.each_with_index do |element, index|
    hash_flintstones[element] = index
end
```



## Problem 2

Add up all of the ages from the Munster family hash:

```ruby
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
```

### My solutions

```ruby
# Very brute force approach
sum_of_ages = ages["Herman"] + ages["Lily"] + ages["Grandpa"] + ages["Eddie"] + ages["Marilyn"] + ages["Spot"]

# More general approach
array_ages = ages.values
sum_of_ages = array_ages.inject(:+)

# other approach
sum_of_ages = 0
ages.each do |key, value|
    sum_of_ages += value
end
```



## Practice Problem 3

In the age hash:

```ruby
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
```

throw out the really old people (age 100 or older).

### My solutions

```ruby
# Many approaches possible

# using Hash#delete_if
ages.delete_if do |key, value|
  value > 100
end

# using Hash#select
ages.select! do |key, value|
    value < 100
end

# using Hash#reject
ages.reject! do |key, value|
    value > 100
end
```

### LA proposed solution

```ruby
ages.keep_if { |_, age| age < 100 }

# You could also use select! here. When using similar methods however, it is important to be aware of the subtle differences in their implementation. For example, the Ruby Documentation for Hash#select! tells us that it is "Equivalent to Hash#keep_if, but returns nil if no changes were made", though in this case that wouldn't have made any difference.
```

##### 

## Problem 4

Pick out the minimum age from our current Munster family hash:

```ruby
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
```

### My solutions

```ruby
ages.values.min
```



## Problem 5

In the array:

```ruby
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
```

Find the index of the first name that starts with "Be"

### My solutions

```ruby
# One solution using #loop
def indice_of_word_starting_with(input_array)
  iterator = 0
  loop do
    break if input_array[iterator].start_with?('Be')
    iterator += 1
  end
  puts iterator
end

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
indice_of_word_starting_with(flintstones)

# One solution using #each_with_index
flintstones.each_with_index do |element, index|
    if element.start_with?('Be')
        puts index
    end
end
    
```

### LA proposed solution

```ruby
flintstones.index { |name| name[0, 2] == "Be" }
```



## Problem 6

Amend this array so that the names are all shortened to just the first three characters:

```ruby
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
```

### My solutions

```ruby
flintstones.map! do |element|
    elements = element[0, 3]
end
```



## Problem 7

Create a hash that expresses the frequency with which each letter occurs in this string:

```ruby
statement = "The Flintstones Rock"
```

ex:

```ruby
{ "F"=>1, "R"=>1, "T"=>1, "c"=>1, "e"=>2, ... }
```

### My solutions

```ruby
statement = "The Flintstones Rock"
statement_array = statement.chars
hash_of_characters_count = {}

statement_array.each_with_index do |value, index|
  hash_of_characters_count[value] = statement_array.count(value)
end
```

### LA Solution

```ruby
statement = "The Flintstones Rock"
result = {}
letters = ('A'..'Z').to_a + ('a'..'z').to_a
letters.each do |letter|
  letter_frequency = statement.scan(letter).count
  result[letter] = letter_frequency if letter_frequency > 0
end

### Without the #scan method

statement = "The Flintstones Rock"
result = {}
letters = ('A'..'Z').to_a + ('a'..'z').to_a
letters.each do |letter|
  letter_frequency = statement.count(letter)
  result[letter] = letter_frequency if letter_frequency > 0
end
```



## Problem 8

What happens when we modify an array while we are iterating over it? What would be output by this code?

```ruby
numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end
```

What would be output by this code?

```ruby
numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end
```

### LA proposed solution

```ruby
first one...

1
3
second one...

1
2
To better understand what is happening here, we augment our loop with some additional "debugging" information:

numbers = [1, 2, 3, 4]
numbers.each_with_index do |number, index|
  p "#{index}  #{numbers.inspect}  #{number}"
  numbers.shift(1)
end

#The output is:

"0  [1, 2, 3, 4]  1"
"1  [2, 3, 4]  3"
#From this we see that our array is being changed as we go (shortened and shifted), and the loop counter used by #each is compared against the current length of the array rather than its original length.

#In our first example, the removal of the first item in the first pass changes the value found for the second pass.

#In our second example, we are shortening the array each pass just as in the first example...but the items removed are beyond the point we are sampling from in the abbreviated loop.

#In both cases we see that iterators DO NOT work on a copy of the original array or from stale meta-data (length) about the array. They operate on the original array in real time.

# AUTREMENT DIT EN FRANCAIS

# Dans le premier cas le code output la premiere valeur puis supprime la suivante puis imprime la suivante et enfin supprime la derniere.


```



## Problem 9

#### Practice Problem 9

As we have seen previously we can use some built-in string methods to change the case of a string. A notably missing method is something provided in Rails, but not in Ruby itself...`titleize`. This method in Ruby on Rails creates a string that has each word capitalized as it would be in a title. For example, the string:

```ruby
words = "the flintstones rock"
```

would be:

```ruby
words = "The Flintstones Rock"
```

Write your own version of the rails `titleize` implementation.

### My solutions

```ruby
def titleize(string)
  capitalized_words = string.split.map! do |word|
    word.capitalize
  end
  capitalized_words.join(' ')
end
```



## Problem 10

Given the `munsters` hash below

```ruby
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}
```

Modify the hash such that each member of the Munster family has an additional "age_group" key that has one of three values describing the age group the family member is in (kid, adult, or senior). Your solution should produce the hash below

```ruby
{ "Herman" => { "age" => 32, "gender" => "male", "age_group" => "adult" },
  "Lily" => {"age" => 30, "gender" => "female", "age_group" => "adult" },
  "Grandpa" => { "age" => 402, "gender" => "male", "age_group" => "senior" },
  "Eddie" => { "age" => 10, "gender" => "male", "age_group" => "kid" },
  "Marilyn" => { "age" => 23, "gender" => "female", "age_group" => "adult" } }
```

Note: a kid is in the age range 0 - 17, an adult is in the range 18 - 64 and a senior is aged 65+.

### My solutions

```ruby
# Hint use case statement and ruby Range object.

# Shit!!!
```

### LA solution

```ruby
munsters.each do |name, details|
  case details["age"]
  when 0...18
    details["age_group"] = "kid"
  when 18...65
    details["age_group"] = "adult"
  else
    details["age_group"] = "senior"
  end
end
```

