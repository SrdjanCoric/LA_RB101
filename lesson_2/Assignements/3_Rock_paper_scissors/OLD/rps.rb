VALID_CHOICE = %w(rock paper scissors)

def prompt(message)
  puts("=> #{message}")
end

def win?(player1, player2)
  (player1 == 'rock' && player2 == 'scissors') ||
    (player1 == 'paper' && player2 == 'rock') ||
    (player1 == 'scissors' && player2 == 'paper')
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won")
  elsif win?(computer, player)
    prompt("Computer won")
  else
    prompt("It's a tie")
  end
end

loop do
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICE.join(', ')}")
    choice = gets.chomp

    if VALID_CHOICE.include?(choice)
      break
    else
      prompt("That is not a valid choice")
    end
  end

  computer_choice = VALID_CHOICE.sample
  prompt("You chose: #{choice} and computer chose: #{computer_choice}")

  display_results(choice, computer_choice)

  loop do
    prompt("Do you want to play again?")
    answer = gets.chomp
    if answer.downcase == 'y'
      break
    elsif answer.downcase == 'n'
      prompt("Thank you for playing this game")
      exit
    else
      prompt("Please enter a valid answer or Spock will desintegrate you: y/n?")
    end
  end
end
