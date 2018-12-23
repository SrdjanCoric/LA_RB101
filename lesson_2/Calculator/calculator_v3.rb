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

operation_to_message = {"1"=>"Adding",
                        "2"=>"Substracting",
                        "3"=>"Multiplying",
                        "4"=> 'Dividing'  }

def calculation(num1, num2, operator)
  case operator
  when '1' then num1 + num2
  when '2' then num1 - num2
  when '3' then num1 * num2
  when '4' then num1 / num2
  end
end

def divide(num1, num2)
  begin
    answer = num1 / num2
  rescue ZeroDivisionError => e
    puts "Error: numbers cannot be " + e.message
  end
end

prompt(MESSAGES['welcome'])

your_name = ''
loop do
  your_name = gets.chomp
  if /[0-9]/.match(your_name.to_s) || /[\s]/.match(your_name.to_s) || your_name.empty?
    prompt(MESSAGES['name'])
  else
    break
  end
end

prompt("Hello #{your_name}")

loop do # main loop
  number1 = ''
  loop do
    prompt(MESSAGES['number1'])
    number1 = gets.chomp

    if valid_number?(number1)
      break
    else
      prompt(MESSAGES['number_error'])
    end
  end

  number2 = ''
  loop do
    prompt(MESSAGES['number2'])
    number2 = gets.chomp

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
    operator = gets.chomp

    if ["1", "2", "3", "4"].include?(operator) # possibility to use %w(1 2 3 4)
      break
    else
      prompt(MESSAGES['operator_error'])
    end
  end

  prompt("#{operation_to_message[operator]} the two numbers...")

  if number_input?(number1, number2)
    number1 = number1.to_i
    number2 = number2.to_i
  else
    number1 = number1.to_f
    number2 = number2.to_f
  end

  result = if operator == '4' && number2 == 0
            divide(number1, number2)
           else
            calculation(number1, number2, operator)
           end

  prompt("The results is: #{result}")

  prompt(MESSAGES['another_operation'])
  answer = gets.chomp

    loop do
      if answer.downcase == 'y'
        break
      elsif answer.downcase == 'n'
        exit
      else
        prompt("ERROR: Please put an appropriate answer (Y or N)")
        prompt(MESSAGES['another_operation'])
        answer = gets.chomp
      end
    end
end

prompt(MESSAGES['goodbye'])
