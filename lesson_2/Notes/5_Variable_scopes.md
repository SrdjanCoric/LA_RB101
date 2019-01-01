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



- 