# Loan calculator.rb
# Abbreviation: apr => Annual Percentage rate

require 'yaml'
MESSAGES = YAML.load_file('loan_calcul_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def loan_amount?(value)
  value.to_i.to_s == value && value.to_i > 0
end

def valid_apr?(value)
  value.to_i.to_s == value || value.to_f.to_s == value
end

def duration_integer?(number_of_year)
  number_of_year.to_i.to_s == number_of_year
end

def duration_float?(number_of_year)
  number_of_year.to_f.to_s == number_of_year
end

welcome_prompt = <<~MSG
  Welcome to our loan calculator.
     You will be guided step-wise through the process.
     Firstly, please enter your name.
MSG

prompt(welcome_prompt)

name = ''
loop do
  name = gets.chomp.strip
  if /[0-9]/.match(name.to_s) || /[\s]/.match(name.to_s) || name.empty?
    prompt(MESSAGES['invalid_name'])
  else
    prompt("Hello #{name}")
    break
  end
end

loop do
  prompt(MESSAGES['loan'])

  loan_amount = ''
  loop do
    loan_amount = gets.chomp
    break if loan_amount?(loan_amount)
    prompt(MESSAGES['loan_error'])
  end

  prompt(MESSAGES['apr'])
  prompt(MESSAGES['apr_example'])

  apr = ''
  loop do
    apr = gets.chomp
    break if valid_apr?(apr)
    prompt(MESSAGES['apr_error'])
  end

  prompt(MESSAGES['duration'])

  loan_duration = ''
  loop do
    loan_duration = gets.chomp
    break if duration_integer?(loan_duration) || duration_float?(loan_duration)
    prompt(MESSAGES['duration_error'])
  end

  monthly_interest_rate = (apr.to_f / 100) / 12

  loan_duration = if duration_integer?(loan_duration)
                    loan_duration.to_i * 12
                  else
                    loan_duration.to_f.round(1) * 12
                  end

  monthly_payment = loan_amount.to_f *
                    (monthly_interest_rate /
                      (1 - (1 + monthly_interest_rate)**-loan_duration))

  prompt("You interest rate by month is: #{monthly_interest_rate.round(5)}")
  prompt("The duration of your loan is: #{loan_duration.to_i} months")
  prompt("You will pay #{monthly_payment.round(2)}$ by month")

  prompt(MESSAGES['retry'])
  answer = gets.chomp.downcase

  loop do
    if answer.downcase == 'y'
      break
    elsif answer.downcase == 'n'
      prompt("Thank you #{name} for using our loan calculator")
      exit
    else
      prompt("ERROR: Please put an appropriate answer (Y or N)")
      prompt(MESSAGES['retry'])
      answer = gets.chomp.downcase
    end
  end
end
