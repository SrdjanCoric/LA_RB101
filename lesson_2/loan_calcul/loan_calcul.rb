# Loan calculator.rb
# Abbreviation: apr => Annual Percentage rate
# Abbreviation: l_d_y_i? => loan_duration_year_integer?
# Abbreviation: l_d_y_f? => loan_duration_year_float?

require 'yaml'
MESSAGES = YAML.load_file('loan_calcul_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def loan_amount?(num)
  num.to_i.to_s == num && num.to_i > 0
end

def valid_apr?(num)
  num.to_i.to_s == num || num.to_f.to_s == num
end

def l_d_y_i?(num)
  num.to_i.to_s == num
end

def l_d_y_f?(num)
  num.to_f.to_s == num
end

welcome_prompt = <<~MSG
  Welcome to our loan calculator.
     You will be guided step-wise through the process.
     But first, please enter your name.
MSG

prompt(welcome_prompt)

your_name = ''
loop do
  your_name = gets.chomp.strip
  if /[0-9]/.match(your_name.to_s) || /[\s]/.match(your_name.to_s)
    prompt(MESSAGES['invalid_name'])
  else
    prompt("Hello #{your_name}")
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
    break if l_d_y_i?(loan_duration) || l_d_y_f?(loan_duration)
    prompt(MESSAGES['duration_error'])
  end

  monthly_interest_rate = (apr.to_f / 100) / 12

  loan_duration = if l_d_y_i?(loan_duration)
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
  break if answer == 'n'
end

prompt("Thank you #{your_name} for using our loan calculator")
