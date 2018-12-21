### Extra features for the calculator program



#### 1. Better integer validation.

The current method of validating the input for a number is very weak. It's also not fully accurate, as you cannot enter a `0`. Come up with a better way of validating input for integers.

#### ***My solution***

```ruby
def valid_integer?(num)
  num.to_i.to_s == num
end
```

#### ***Possible solutions***

**Option 1** - this is the easiest way to improve the method. It will handle "0" correctly.

```ruby
def integer?(input)
  input.to_i.to_s == input
end
```

This isn't perfect, however, because while `"0"` will return `true`, if we input `"00"`, this method will return `false`.

**Option 2** - use regex. Slightly more complex, but we're using the `\d` regular expression to test against all digits. The `^` means start of string, the `+` means "one or more" (of the preceding matcher), and the `$` means end of string. Therefore, it has to be an integer, and a float, like `4.5`won't match. When there's a match, the `match` method will return a `MatchData` object, which will evaluate to true. When there's no match, it'll return `nil`, which will evaluate to false.

```ruby
def integer?(input)
  /^\d+$/.match(input)
end
```

**Option 3** - use built-in conversion method. In Ruby, there's a method called `Kernel#Integer` that will convert parameters to the method into an integer object. It will, however, raise a `TypeError` if the input is not a valid integer, so you'll have to handle that. Note: yes, that's a capitalized method in Ruby -- fortunately, that doesn't happen often.

Note: trailing `rescue` is a "code smell", so be aware of that. In this specific instance, it's ok, but don't fall into a habit of suppressing errors this way.

```ruby
def integer?(input)
  Integer(input) rescue false
end
```

Option 1 is really what you're expected to come up with at this point. The other two are merely to show you that there are frequently multiple ways to do the same thing in Ruby, with varying degrees of differences.



#### 2. Number validation.

Suppose we're building a scientific calculator, and we now need to account for inputs that include decimals. How can we build a validating method, called `number?`, to verify that only valid numbers -- integers or floats -- are entered?

#### ***My solution***

```ruby
def valid_number?(num)
  num.to_i.to_s == num || num.to_f.to_s == num
end
```

#### ***Possible solutions***

We'll create a method that tests to see whether the input is either a number or a float.

```ruby
def number?(input)
  integer?(input) || float?(input)
end
```

We already have the `integer?` method, so all we need to do is implement a `float?` method.

Option 1 -- just like before, this is the easiest way to check for floats.

```ruby
def float?(input)
  input.to_f.to_s == input
end
```

This method has an edge case though:

```ruby
2.2.2 :001 > '1.' == '1.'.to_f.to_s
=> false
2.2.2 :002 > '1.'.to_f
=> 1.0
```

As you can see, `to_f` converts `1.` to `1.0`, which does not match the original string.

Option 2 -- use regex. This regex is similar to the regex in the `integer?` method, except we have to account for more possible formats. We can combine two validations to verify that the input is a valid float. The first validation verifies that there is at least one digit in the input. The second validation incorporates the `*` which stands for "zero or more", and the `?` which stands for "zero or one". This validation can be read as "zero or more digits, followed by an optional period, followed by zero or more digits. This validation will accept all of these formats: `11.11`, `11.`, `.11`, but not a period by itself. Notice that we had to prefix the `.` with a backslash. That is because `.` matches any single character in regex. By escaping it, we tell Ruby that we are looking for the actual period character.

```ruby
def float?(input)
  /\d/.match(input) && /^\d*\.?\d*$/.match(input)
end
```

Option 3 -- use the `Kernel#Float` method, which is analogous to the `Kernel#Integer` method from earlier. Just like that method, `Float` also raises an exception if you don't give it a valid float, so you have to handle it. Note: trailing `rescue` is a "code smell", so be aware of that. In this specific instance, it's ok, but don't fall into a habit of suppressing errors this way.

```ruby
def float?(input)
  Float(input) rescue false
end
```

Of the 3 options, option 1 is probably easiest to follow. Using regex seems like a good idea, until you start to run into very subtle edge cases with it.

One last thing to mention is that in programming, no matter what language you use, there's always the [floating point precision problem](https://en.wikipedia.org/wiki/Floating_point#Accuracy_problems). Be aware of that when dealing with large numbers, or working with the result of a division operation.



#### 3. Operation message - case statement.

Our `operation_to_message` method is a little dangerous, because we're relying on the case statement being the last expression in the method. What if we needed to add some code after the case statement within the method? What changes would be needed to keep the method working with the rest of the program?

#### ***Possible solutions***

If we wanted to add code after the `case` statement, we would need to save the return value of the `case` into a variable, then make sure to return that variable, or that variable must be the last line in the method.

```ruby
def operation_to_message(operation)
  word = case operation
           when '1'
             'Adding'
           when '2'
             'Subtracting'
           when '3'
             'Multiplying'
           when '4'
             'Dividing'
         end

  x = "A random line of code"

  word
end
```



#### 4. Extracting messages in the program to a configuration file.

There are lots of messages sprinkled throughout the program. Could we move them into some configuration file and access by key? This would allow us to manage the messages much easier, and we could even internationalize the messages.



#### Possible solutions

First, we need to extract the messages into a configuration file. We can choose any format, from plain .txt file to json to csv. Ruby has libraries that can help with parsing any of those formats. Most Rubyists prefer the [yaml format](http://www.yaml.org/start.html), so we'll use that. We'll extract our messages into a file called `calculator_messages.yml`. Make sure this file is created in the same directory as your calculator program.

```yaml
calculator_messages.yml
welcome: "Welcome to Calculator! Enter your name:"
valid_name: "Make sure to enter a valid name."

# ... rest of file omitted for brevity
```

As you can see, it's just a list of key/value pairs, almost like a hash. Next, we'll parse this .yml file using a [module](http://ruby-doc.org/stdlib-2.1.0/libdoc/yaml/rdoc/YAML.html) that comes with the Ruby standard Library.

To use that module, in your `calculator.rb` file, add `require 'yaml'` and you can parse the `calculator_messages.yml` file, then save the parsed data into a variable.

```ruby
calculator.rb# at the top of file

require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')
```

Before continuing, check out what `MESSAGES` is. You can do so with `puts MESSAGES.inspect`. Go do that now. We'll wait....

If you did that, you should have seen that `MESSAGES` is a normal Ruby hash. The `yaml` gem parsed the contents of the yml file, and created a Ruby hash for us. This is convenient, because we know how to work with hashes.

Now, all we have to do is replace all hard-coded strings with the key in the `MESSAGES` hash.

```ruby
# replace this:
prompt("Welcome to Calculator! Enter your name:")

# with this:
prompt(MESSAGES['welcome'])
```

Go ahead and replace all the `prompt` calls. Your program is now using a configuration file!