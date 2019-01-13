### Question 1

In this hash of people and their age,

```ruby
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
```

see if "Spot" is present.

**Bonus:** What are two other hash methods that would work just as well for this solution?

#### My solution

```ruby
#1 
ages.include?("Spot")

#2
ages.has_key?("Spot")

#3
ages.key?("Spot")
```

#### LA solution

```ruby
#1
ages.key?("Spot")

#2
ages.include?("Spot")

#3
ages.member?("Spot")
```



### Question 2

Starting with this string:

```ruby
rubmunsters_description = "The Munsters are creepy in a good way."
```

Convert the string in the following ways (code will be executed on original munsters_description above):

```irb
"tHE mUNSTERS ARE CREEPY IN A GOOD WAY."
"The munsters are creepy in a good way."
"the munsters are creepy in a good way."
"THE MUNSTERS ARE CREEPY IN A GOOD WAY."
```

#### My solution

```ruby
rubmunsters_description.swapcase! 		# "tHE mUNSTERS ARE CREEPY IN A GOOD WAY."
rubmunsters_description.capitalize! 	# "The munsters are creepy in a good way."
rubmunsters_description.downcase!   	# "the munsters are creepy in a good way."
rubmunsters_description.upcase!     	# "THE MUNSTERS ARE CREEPY IN A GOOD WAY."
```



### Question 3

We have most of the Munster family in our age hash:

```ruby
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
```

add ages for Marilyn and Spot to the existing hash

```ruby
additional_ages = { "Marilyn" => 22, "Spot" => 237 }
```

#### My solution

```ruby
ages.merge!(additional_ages)
```



### Question 4

See if the name "Dino" appears in the string below:

```ruby
advice = "Few things in life are as important as house training your pet dinosaur."
```

#### My Solution

```ruby
#1
advice.include?('Dino') # ==> False

#2
advice.match('Dino')    # ==> nil
```



### Question 5

Show an easier way to write this array:

```ruby
flintstones = ["Fred", "Barney", "Wilma", "Betty", "BamBam", "Pebbles"]
```

#### My solution

```ruby
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
```



### Question 6

How can we add the family pet "Dino" to our usual array:

```ruby
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
```

#### My answer

```ruby
flintstones << 'Dino'
```



### Question 7

In the previous practice problem we added Dino to our array like this:

```ruby
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones << "Dino"
```

We could have used either `Array#concat` or `Array#push` to add Dino to the family.

How can we add multiple items to our array? (Dino and Hoppy)

#### My solution

```ruby
#1
flintstones << "Dino" << "Hoppy"

#2
flintstones.push("Dino").push("Hoppy")

#3
flintstones.concat(["Dino", "Hoppy"])
```

#### LA solution

```ruby
flintstones.push("Dino").push("Hoppy")   # push returns the array so we can chain

# or

flintstones.concat(%w(Dino Hoppy))  # concat adds an array rather than one item
```



### Question 8

Shorten this sentence:

```ruby
advice = "Few things in life are as important as house training your pet dinosaur."
```

...remove everything starting from "house".

Review the [String#slice!](http://ruby-doc.org/core-2.2.0/String.html#method-i-slice-21) documentation, and use that method to make the return value `"Few things in life are as important as "`. But leave the `advice` variable as `"house training your pet dinosaur."`.

As a bonus, what happens if you use the [String#slice](http://ruby-doc.org/core-2.2.0/String.html#method-i-slice) method instead?

#### My solution

```ruby
advice.slice!(0..38)
```

If using `String#slice` we would not have mutated advice. advice would be still equal to `"Few things in life are as important as house training your pet dinosaur."`

#### LA solution

```ruby
advice.slice!(0, advice.index('house'))
```



### Question 9

Write a one-liner to count the number of lower-case 't' characters in the following string:

```ruby
statement = "The Flintstones Rock!"
```

#### My solution

```ruby
statement.count('t')
```



### Question 10

ack in the stone age (before CSS) we used spaces to align things on the screen. If we had a 40 character wide table of Flintstone family members, how could we easily center that title above the table with spaces?

```ruby
title = "Flintstone Family Members"
```

#### My solution

```ruby
title.center(40)
```

