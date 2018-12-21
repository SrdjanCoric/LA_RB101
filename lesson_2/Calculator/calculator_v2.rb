# ask the user for two numbers
# ask the user for an operation to perform
# Perform the operation
# Display the result

# answer = Kernel.gets()
# Kernel.puts(answer)

require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  puts("=> #{message}")
end

def integer?(num)
  num.to_i.to_s == num
end

def float?(num)
  num.to_f.to_s == num
end

def valid_number?(num)
  float?(num) || integer?(num)
end

def number_input?(num1, num2)
  integer?(num1) && integer?(num2) 
end
# This method will allow to make choice toward the user input. 
# if both numbers are integers then do the calculation accodingly.
# if one of them is floats result will be display as float

def operation_to_message(operator)
  case operator
  when '1' then 'Adding'
  when '2' then 'Substracting'
  when '3' then 'Multiplying'
  when '4' then 'Dividing'
  end
end

def calculation(num1, num2, operator)
  case operator
  when '1' then num1 + num2
  when '2' then num1 - num2
  when '3' then num1 * num2
  when '4' then num1 / num2
  end
end

prompt(MESSAGES['welcome'])

name = ''
loop do
  name = gets.chomp

  if name.empty?
    prompt(MESSAGES['name'])
  else
    break
  end
end

prompt("Hello #{name}")

loop do # main loop
  number1 = ''
  loop do
    prompt(MESSAGES['number1'])
    number1 = gets().chomp()

    if valid_number?(number1)
      break
    else
      prompt(MESSAGES['number_error'])
    end
  end

  number2 = ''
  loop do
    prompt(MESSAGES['number2'])
    number2 = gets().chomp()

    if valid_number?(number2)
      break
    else
      prompt(MESSAGES['number_error'])
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
    operator = gets().chomp()

    if ["1", "2", "3", "4"].include?(operator) # possibility to use %w(1 2 3 4)
      break
    else
      prompt(MESSAGES['operator_error'])
    end
  end

  prompt("#{operation_to_message(operator)} the two numbers...")

  if number_input?(number1, number2)
    number1 = number1.to_i
    number2 = number2.to_i
  else
    number1 = number1.to_f
    number2 = number2.to_f
  end

  result = calculation(number1, number2, operator)

  prompt("The results is: #{result}")

  prompt(MESSAGES['another_operation'])
  answer = gets().chomp()
  break unless answer.downcase == 'y'
end

prompt(MESSAGES['goodbye'])
