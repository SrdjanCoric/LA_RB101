### FlowChart

*See textbook for complementary notes.*

Here let's discuss and follow the bigger example

**Example**

Let's suppose that the above flowchart is mapping out a solution to part of a larger problem. Let's suppose that in our larger problem, we're asking the user to give us N collections of numbers. We want to take the largest number out of each collection, and display it.



Here the following problem translated into pseudo code (Casual)

```
while user wants to keep going
  - ask the user for a collection of numbers
  - extract the largest one from that collection and save it
  - ask the user if they want to input another collection

return saved list of numbers
```

`extract the largest one from that collection` is a sub-process that itself contains a lot of logic. We already decorticate this logic before in the previous lesson ("Pseudo Code").

Thus, `extract the largest one from that collection` is a great candidate for a sub-process. We can obviously turn that sub-process into a method. But let's not even think about "methods" yet.



If we develop the all process in pseudo code by deploying the sub-process we would get this type of pseudo code:

```
while user wants to keep going
  - ask the user for a collection of numbers
  - iterate through the collection one by one.
    - save the first value as the starting value.
    - for each iteration, compare the saved value with the current value.
    - if the saved value is greater, or it's the same
      - move to the next value in the collection
    - otherwise, if the current value is greater
      - reassign the saved value as the current value

  - after iterating through the collection, save the largest value into the list.
  - ask the user if they want to input another collection

return saved list of numbers
```

When pseudo code is too long it is difficult to handle and trust the accuracy of the logic. (remember, you can only verify the logic by running actual program code). Therefore, it's prudent to extract a logical grouping into a sub-process, and to tackle the various pieces separately. Decomposing big problem in small piece will allow to tackle the problem more easily. 



Now let's translate the shorten casual pseudo code into formal pseudo code:

```markdown
START

SET large_numbers = []
SET keep_going = true

WHILE keep_going == true
  GET "enter a collection"
  SET collection
  SET largest_number = SUBPROCESS "extract the largest one from that collection"
  large_numbers.push(largest_number) **this comes from the previous assessment**
  GET "enter another collection?"
  IF "yes"
    keep_going = true
  ELSE
    keep_going = false
  IF keep_going == false
    exit the loop

PRINT large_numbers

END
```

Notice that we have a `SUBPROCESS` keyword to show that there's some other *thing* that will take care of extracting the largest number out of a collection. Just like before, we could have included the entire formal pseudo-code from the previous assignment, but that would have made it very long, and our confidence in such long pseudo-code cannot be very good. Extracting to sub-processes helps us focus on a well defined narrowly scoped set of pseudo-code.


We can now translate this into flow-charts

![img](http://d1b1wr57ag5rdp.cloudfront.net/images/flowchart_larger_problem.jpg)



The interesting part about this flowchart is the processing square in the middle `num = find_largest(collection)`. This is our sub-process. You can think of this square as the zoomed-out high level view of the very first flowchart from the top of this assignment. (See textbook)

Using sub-processes, allow to use a *declarative* type of syntax, rather than *imperative*. In other words, we can say "find_largest", rather than outline step by step how the logic should be as we did in our seond example of pseudo code. 

Thinking about the high level logic flows allows you to create sub-processes to narrow down the scope of your application. From a high level, writing declarative code segments/divide our program into logical sections, allowing us to focus on one section at a time. 

For example, if we wanted to add a validation feature to our program, we could have a sub-process that returns `true` or `false` given an input. We can just call it `validate_input` and represent it as a square in our flowchart, without having to layout the step-by-step imperative logic that's required to validate the user's input. From a high level, we can trust that this sub-process will do its job -- it will only return true or false. When we're ready to work on the logic in that `validate_input` sub-process, we can forget about the larger program, and just focus on the responsibilities of this sub-process.



**Let's apply this logic to our calculator**

```
Casual pseudo code by myself
- Get the first number
	- Check if the number is valid and ask another one if necessary
- Get the second number
	- Check if the number is valid and ask another one if necessary
- Get the operator 
	- ask to choose among four possibilities

- Perform operation
- Display the results
- Ask for a new operation if necessary
```

```
Casual pseudo code by LA School

- Get the first number
  - Make sure it's valid, otherwise, ask for another
- Get the second number
  - Make sure it's valid, otherwise, ask for another
- Get the operator
  - Make sure it's valid, otherwise, ask again

- Perform operation on the two numbers
- Display result
- Ask if user wants to do another calculation
```

In the above, you're not yet outlining exactly how to validate the inputs. No specifics or imperative style pseudo-code yet. Once you have the high level steps, it's time to drill down a level into imperative pseudo-code and outline specifics.