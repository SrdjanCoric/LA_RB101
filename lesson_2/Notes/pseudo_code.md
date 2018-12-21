### About the importance of using Pseudo Code for problem solving

To solve a problem, two important steps

	- Spend time loading the porblem in my brain
	- Then dissect, understand and establish an execution path to solve it

There is one major limitation when we just start learning language programming: 
**being confronted to the synthax and problem solving at the same time**

As such it is very important to first tackle the problem in a appropriate way (PEDAC) end once this is done we can
think about coding. Approaching problem solving stepwise is very important and using pseudo code which basically using english
to formalise the problem and its execution will help a lot.

Here a few keyword that I can use when doing so:

We'll use the below keywords to assist us, along with their meaning.

#### **keyword meaning**

| **START**               | Start the program                    |
| ----------------------- | ------------------------------------ |
| **SET**                 | sets a variable we can use for later |
| **GET**                 | retrieve input from user             |
| **PRINT**               | displays output to user              |
| **READ**                | retrieve value from variable         |
| **IF / ELSE IF / ELSE** | show conditional branches in logic   |
| **WHILE**               | show looping logic                   |
| END                     | **End of the program**               |



#### Working example

**With plain English pseudo code**

```
Given a collection of integers.

Iterate through the collection one by one.
  - save the first value as the starting value.
  - for each iteration, compare the saved value with the current value.
  - if the saved value is greater, or it's the same
    - move to the next value in the collection
  - otherwise, if the current value is greater
    - reassign the saved value as the current value

After iterating through the collection, return the saved value.
```



**When using Keywords**

```
START

# Given a collection of integers called "numbers"

SET iterator = 1
SET saved_number = value within numbers collection at space 1

WHILE iterator <= length of numbers
  SET current_number = value within numbers collection at space "iterator"
  IF saved_number >= current_number
    go to the next iteration
  ELSE
    saved_number = current_number

  iterator = iterator + 1

PRINT saved_number

END
```



**Translated into Ruby**

```ruby
def find_greatest(numbers)
  saved_number = nil

  numbers.each do |num|
    saved_number ||= num  # assign to first value
    if saved_number >= num
      next
    else
      saved_number = num
    end
  end

  saved_number
end
```



#### Small exercices

For example, write out pseudo-code (both casual and formal) that does the following:

1. a method that returns the sum of two integers

```
Casual
Given two numbers 
- calculate their sum

Formal
START

# Given two integers called number_1 and number_2

SET number_1 = a
SET number_2 = b

PRINT a + b

END
```



2. a method that takes an array of strings, and returns a string that is all those strings concatenated together

   ```
   Casual
   Given an array of strings. Print a string that contains all element of the array concatenated together
   
   Formal
   START
   
   # Given an array of string, concatenate all element to form a new string
   
   SET array = []
   SET string = array.join
   
   PRINT string
   
   END
   ```


3. a method that takes an array of integers, and returns a new array with every other element

