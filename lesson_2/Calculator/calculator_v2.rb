# ask the user for two numbers
# ask the user for an operation to perform
# Perform the operation
# Display the result

# answer = Kernel.gets()
# Kernel.puts(answer)

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  num.to_i() != 0
end

def operation_to_message(op)
  case op
  when '1'
    'Adding'
  when '2'
    'Substracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

prompt("Welcome to Calculator! Please enter your name:")

name = ''
loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt("Mak sure to use a valid name.")
  else
    break
  end
end

prompt("Hello #{name}")

loop do # main loop
  number1 = ''
  loop do
    prompt("What is the first number?")
    number1 = Kernel.gets().chomp()

    if valid_number?(number1)
      break
    else
      prompt("ERROR: Please enter a valid number")
    end
  end

  number2 = ''
  loop do
    prompt("What is the second number?")
    number2 = Kernel.gets().chomp()

    if valid_number?(number2)
      break
    else
      prompt("ERROR: Please enter a valid number")
    end
  end

  operator_prompt = <<~MSG
    What operation would you like to perform?
    1) Add
    2) Substract
    3) Multiply
    4) Divide
  MSG

  prompt(operator_prompt)

  operator = ''
  loop do
    operator = Kernel.gets().chomp()

    if ["1", "2", "3", "4"].include?(operator) # possibility to use %w(1 2 3 4)
      break
    else
      prompt("ERROR: Make sure to enter choice 1, 2, 3 or 4")
    end
  end

  prompt("#{operation_to_message(operator)} the two numbers...")

  result = case operator
           when '1'
             number1.to_i() + number2.to_i()
           when '2'
             number1.to_i() - number2.to_i()
           when '3'
             number1.to_i() * number2.to_i()
           when '4'
             number1.to_f() / number2.to_f()
           end

  prompt("The results is: #{result}")

  prompt("Do you want to perform another opeartion? (Y or N)")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for using our calculator program!")
