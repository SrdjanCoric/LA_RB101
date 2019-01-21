## Problem 1

Given the array below

```ruby
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
```

Turn this array into a hash where the names are the keys and the values are the positions in the array.

### My solution

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



#### Practice Problem 3

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

