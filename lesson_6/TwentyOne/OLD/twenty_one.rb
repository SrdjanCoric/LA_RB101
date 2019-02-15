CARD_DECK = ['1', '2', '3',
             '4', '5', '6',
             '7', '8', '9',
             '10', 'J', 'Q',
             'K']
CARD_VALUE = {
              '1'=> 11, '2'=> 2, '3'=> 3,
              '4'=> 4, '5'=> 5, '6'=> 6,
              '7'=> 7, '8'=> 8, '9'=> 9,
              '10'=> 10, 'J'=> 10,
              'Q'=> 10, 'K'=> 10
              }
player_hand = []
dealer_hand = []
TWENTY_ONE = 21

def prompt(string)
  puts "=> #{string}"
end

def invalid_name?(input)
  /[0-9]/.match(input) || /[\s]/.match(input) || input.empty?
end

def delear_card_attribution(card_hand)
  card_hand << CARD_DECK.sample
  card_hand << CARD_DECK.sample
end

def display_dealer_hand(card_hand)
  puts "Dealer has #{card_hand[0]}, and an unknown card"
end

def calculate_delear_hand(card_hand, card_value)
  hand_value = 0
  card_hand.each do |card|
    hand_value += card_value[card]
  end
  hand_value
end

def player_card_attribution(card_hand, name)
  card_hand[0] = CARD_DECK.sample
  card_hand[1] = CARD_DECK.sample
end

def display_player_hand(card_hand, name)
  puts "#{name} has #{card_hand[0]}, #{card_hand[1]}"
end

def calculate_player_hand(card_hand, card_value, name)
  hand_value = 0
  card_hand.each do |card|
    hand_value += card_value[card]
  end
  hand_value
end

puts ''
puts '************ WELCOME TO CASINO ROYAL ************'
puts ''
puts 'Ladies or gentlemen it is aPleasure to meet you. '
puts 'I guess you are here to challenge fate and see if'
puts 'destiny will make you rich! I like this and that!'
puts 'In thsi regard, I propose you a simple card game:'
puts 'Twenty One. Rules are simpler.'
puts ''
# Initialisation

player_name = ''

loop do
puts 'Please, tell me what is your name?'
player_name = gets.chomp
 if invalid_name?(player_name)
  puts 'Please enter a correct name'
 else
  puts ''
  puts "Welcome here and thank you for playing #{player_name}"
  puts 'Here you cards my friend'
  break
 end
end
puts''
puts''

# Main Game Loop
player_hand = []
dealer_hand = []

loop do
  delear_card_attribution(dealer_hand)
  player_card_attribution(player_hand, player_name)
  display_dealer_hand(dealer_hand)
  display_player_hand(player_hand, player_name)

  # Player Loop

  loop do
    puts "#{player_name}, do you hit(h) or stay(s)?"
    answer = gets.chomp.downcase
    if answer == 'hit' || answer == 'h'
      player_hand << CARD_DECK.sample
      if calculate_player_hand(player_hand, CARD_VALUE, player_name) > TWENTY_ONE
        puts "Your hand is #{player_hand}"
        puts "You score is #{calculate_player_hand(player_hand, CARD_VALUE, player_name)}"
        puts "Sorry #{player_name}, you bust and I win"
        break
      end
    elsif answer == 'stay' || answer == 's'
      system('clear') || system('cls')
      puts "Ok #{player_name}, now is Dealer's turn"
      loop do
        dealer_hand << CARD_DECK.sample
        if calculate_delear_hand(dealer_hand, CARD_VALUE) >= 17 && calculate_delear_hand(dealer_hand, CARD_VALUE) < TWENTY_ONE
          puts 'Place your bets, no more bets'
          break
        elsif calculate_delear_hand(dealer_hand, CARD_VALUE) > TWENTY_ONE
          puts "My hand is #{dealer_hand}"
          puts "My score is #{calculate_delear_hand(dealer_hand, CARD_VALUE)}"
          puts "Bravo #{player_name}, I bust and You win"
          break
        end
      end
    else
      puts 'Please enter a correct answer: hit(h) or stay(s).'
    end
    break
  end

  loop do
    break if calculate_player_hand(player_hand, CARD_VALUE, player_name) > TWENTY_ONE
    break if calculate_delear_hand(dealer_hand, CARD_VALUE) > TWENTY_ONE
    puts ''
    puts "Your hand is #{player_hand}"
    puts "My hand is #{dealer_hand}"
    puts ''
    puts "My score is #{calculate_delear_hand(dealer_hand, CARD_VALUE)}"
    puts "You score is #{calculate_player_hand(player_hand, CARD_VALUE, player_name)}"

    if calculate_delear_hand(dealer_hand, CARD_VALUE) > calculate_player_hand(player_hand, CARD_VALUE, player_name)
      puts 'Dealer won'
    elsif
      calculate_delear_hand(dealer_hand, CARD_VALUE) < calculate_player_hand(player_hand, CARD_VALUE, player_name)
      puts 'Congratulations! You won'
    elsif calculate_delear_hand(dealer_hand, CARD_VALUE) == calculate_player_hand(player_hand, CARD_VALUE, player_name)
      puts "It's a tie"
    end
    break
  end

  loop do
    puts 'Do you want to challenge your luck again (y/n)?'
    continue = gets.chomp.downcase
    if continue == 'yes' || continue == 'y'
      system('clear') || system('cls')
      break
    elsif continue == 'no' || continue == 'n'
      exit
    else
      puts 'Please enter a correct answer (Yes or y, No or n)'
    end
  end
player_hand.clear
dealer_hand.clear
end
