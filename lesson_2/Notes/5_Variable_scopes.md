# Variables Scopes

### 1. Some definitions

- Variable scopes determine where in the program a variable is available for use. It is **defined by the where the variable is initialized**. .

- Scopes are defined by blocks (`do/end` or `{...}`).  However not all `do/end`constructs are blocks.

- ```ruby
  a = 1
  loop do
      puts a
      break
  end
  # this is a block and it defines an inner scope
  
  a = [1, 2, 3]
  for i in a do
      puts i
  end
  # for loop are not blocks !! DO not define inner scopes
  ```

- To be clear here: **a block is a piece of code following a method invocation**. The block following the method invocation is an argument being passed into the method.


### 2. Blocks create new scopes for local variables

 - *Outer scope variables can be accessed in inner scopes*

 - ```ruby
   a = 1         # outer scope variable
   
   loop do       # the block following the invocation of the `loop` method creates an inner scope
     puts a      # => 1
     a = a + 1   # "a" is re-assigned to a new value. We can change variable so that it 
       		  # affects the variable in the outer scope. We can re-assign already, 				  # defined in the outer scope, from the inner scope.
     break       # necessary to prevent infinite loop
   end
   
   puts a        # => 2  "a" was re-assigned in the inner scope
   ```

- **Variables created/initialized in an outer scope can be accessed in the inner scope. NOT THE REVERSE.**



- *Inner scope variables cannot be accessed in outer scope*

- ```ruby
  loop do       # the block following the invocation of the `loop` method creates an                 # inner scope
    b = 1
    break
  end
  
  puts b        # => NameError: undefined local variable or method `b' for main:Object
  ```



- *Peer scopes do not conflict*

- ```ruby
  2.times do
    a = 'hi'
    puts a      # 'hi' <= this will be printed out twice due to the loop
  end
  
  loop do
    puts a      # => NameError: undefined local variable or method `a' for main:Object
    break
  end
  
  puts a        # => NameError: undefined local variable or method `a' for main:Object
  ```



- *What about nested scopes*

- ```ruby
  a = 1           # first level variable
  
  loop do         # second level
    b = 2
  
    loop do       # third level
      c = 3
      puts a      # => 1
      puts b      # => 2
      puts c      # => 3
      break
    end
  
    puts a        # => 1
    puts b        # => 2
    puts c        # => NameError
    break
  end
  
  puts a          # => 1
  puts b          # => NameError
  puts c          # => NameError
  ```

- let's try now to modify this code to make the the variables b and c accessible in the outer scope

- ```ruby
  a = 5           # first level variable
  b = 6
  c = 7
  
  loop do         # second level
    b = 2
  
    loop do       # third level
      c = 3
      puts a      # => 1
      puts b      # => 2
      puts c      # => 3
      break
    end
  
    puts a        # => 1
    puts b        # => 2
    puts c        # => 3
    break
  end
  
  puts a          # => 1
  puts b          # => 2
  puts c          # => 3
  
  # The difference here is that we assigned values to a, b and c in the outer scope (first level). Then some got re-assigned in blocks (b and c) at deeper levels. This makes all variables accessible by the Kernel.puts() method in the outer scope. 
  ```



- Variables Shadowing

  - `loop...do` blocks do not take arguments. But other methods do. The parameter is literally captured in `||` symbols. 

  - ```ruby
    # Here an example
    [1, 2, 3].each do |n|
        puts n
    end
    
    # n is the parameter
    ```

  - What would happen if a variable was already assigned to n before in an outer scope?

  - ```ruby
    n = 10
    
    [1, 2, 3].each do |n|
      puts n
    end
    
    # Here the puts n will print the values that results from the method disregarding the n = 10 !
    ```

  - This phenomenon is called variable shadowing. It also prevents from making changes in the outer scope

  - ```ruby
    n = 10
    
    1.times do |n|
      n = 11
    end
    
    puts n # => 10
    ```

  - It is better to avoid variable shadowing as much as possible and bugs and confusion can arise from this approach. Here again, naming variables and parameters accordingly and appropriately as described in a previous chapter is the best way to avoid falling into this trap.

### 3. Variables and method definition

The only variables a method definition has access to must be passed into the method definitions (only fro local variables). A method definition has no notion of outer or inner scopes. We must explicitly pass in any parameters to a method definition. 

```ruby
a = 'hi'
def some_method() # no argument here consequently no parameters
    puts a
end

some_method() # ERRORname: Undefined local variable or method 'a'

#To circuvment this problem we can do the following

def some_method()
    a = 'hi'
    puts a
end

some_method() # hi

# or

a = 'hi'
def some_method(a) # here the parameter is a
	puts a
end

def some_method(a)
    puts a
end

some_method(5) # here the method parameter a is assigned to the argument 5 and as a consequence is made availableto the method body as a local variable. That is why we can call here puts a inside the method definition.
```

- **A method definition cannot access local variables in another scope, unless it is passed in the method definition.**
- **Local variables that are not initialized inside a method definition must be passed in as arguments / parameters**



### 4. Blocks within method definition

Rules are the same as defined for blocks

```ruby
def some_method
  a = 1
  5.times do
    puts a
    b = 2
  end

  puts a
  puts b
end

some_method     # => NameError: undefined local variable or method `b' for main:Object
```

To avoid this b should have been defined in the outer scope. Because variables assigned in the inner scope are not accessible in the outer scope. 

### 5. More definitions

**Method definition** is defined using the `def` keyword.

```ruby
def greeting
  puts "Hello"
end
```

**Method invocation** is when we call a method (an existing method from the Ruby Core API/core Library, or a custom method defined ourselves using the `def` keyword.)

```ruby
[1, 2, 3].each { |num| puts num } # from the library
greeting # Calling the greeting method outputs "Hello"
```

Technically any method can be called with a block, but the block is only executed if the method is defined in a particular way. **A block is *part of* the method invocation.** 

In fact, *method invocation* followed by curly braces or `do..end` is the way in which we *define* a block in Ruby (remember your notes block start at `do` and finish at `end` or start at `{` and finish at `}`).

In this configuration the block acts as an argument to the method (Similarly to local variables that can be passed as an argument to a method at invocation).

**Example 1:** method parameter not used

```ruby
def greetings(str) # str is the parameter
  puts "Goodbye"
end

word = "Hello"

greetings(word)

# Outputs 'Goodbye'
```

**Example 2:** method parameter used

```ruby
def greetings(str)
  puts str
  puts "Goodbye"
end

word = "Hello"

greetings(word)

# Outputs 'Hello'
# Outputs 'Goodbye'
```



Both examples has method definition that is defined with one parameter (`str`). The code in example 2 clearly demonstrate how the local variable "Hello" can be reassigned to `str` when passing the variable as an argument in the method. The fact that nothing is printed in example 1 does not mean that nothing happens but rather due to the lack of`puts` method. 



the way in which methods interact with blocks at invocation may be less familiar.

**Example 3:** block not executed

```ruby
def greetings
  puts "Goodbye"
end

word = "Hello"

greetings do
  puts word
end

# Outputs 'Goodbye'
```

**Example 4:** block executed

```ruby
def greetings
  yield
  puts "Goodbye"
end

word = "Hello"

greetings do
  puts word
end

# Outputs 'Hello'
# Outputs 'Goodbye'
```

In Example 3 the `greetings` method is invoked with a block, but the method is not defined to use a block in any way and so the block is not executed.

In Example 4 the `yield` keyword is what controls the interaction with the block, in this case it executes the block once. Since the block has access to the local variable `word`, `Hello` is output when the block is executed. Don't focus here on what `yield` is or how it works; writing methods that take blocks is explored at depth in a later course. The important take-away for now is that blocks and methods can interact with each other; the level of that interaction is set by the method definition and then used at method invocation.

When invoking a method with a block, we aren't just limited to executing code within the block; depending on the method definition, the method can use the *return value* of the block to perform some other action. Consider the following example:

```ruby
a = "hello"

[1, 2, 3].map { |num| a } # => ["hello", "hello", "hello"]
```

The `Array#map` method is defined in such a way that it uses the return value of the block to perform transformation on each element in an array. In the above example, `#map` doesn't have direct access to `a` but it can use the value of `a` to perform transformation on the array since the block *can* access `a` and returns it to `#map`.



- The `def..end` construction in Ruby is method definition
- Referencing a method name, either of an existing method or subsequent to definition, is method invocation
- Method invocation followed by `{..}` or `do..end` defines a block; the block is *part of* the method invocation
- Method definition *sets* a scope for local variables in terms of parameters and interaction with blocks
- Method invocation *uses* the scope set by the method definition