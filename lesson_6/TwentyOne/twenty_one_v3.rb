# require 'pry'

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
# CARD_DECK = ['2', '3', '4', '5', '6']
# CARD_VALUE = { '2'=> 2, '3'=> 3, '4'=> 4, '5'=> 5, '6'=> 6 }

PLAYER_HAND = []
DEALER_HAND = []
TWENTY_ONE = 21

def prompt(string)
  puts ">> #{string}"
end

def invalid_name?(input)
  /[0-9]/.match(input) || /[\s]/.match(input) || input.empty?
end

def refresh_screen
  system('clear') || system('cls')
end

def delear_card_attribution(card_hand)
  card_hand[0] = CARD_DECK.sample
  card_hand[1] = CARD_DECK.sample
end

def display_dealer_hand(card_hand)
  prompt("Dealer has #{card_hand[0]} and an unknown card")
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
  prompt("#{name} has #{card_hand[0]} and #{card_hand[1]}")
end

def calculate_player_hand(card_hand, card_value, name)
  hand_value = 0
  card_hand.each do |card|
    hand_value += card_value[card]
  end
  hand_value
end

def player_busted?(card_hand, card_value, name)
  calculate_player_hand(card_hand, card_value, name) > TWENTY_ONE ? true : false
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
prompt('Please, tell me what is your name?')
player_name = gets.chomp
refresh_screen
 if invalid_name?(player_name)
  prompt('Please enter a correct name')
 else
  puts ''
  puts "Welcome here and thank you for playing #{player_name}"
  puts 'Here your cards.'
  break
 end
end
puts''


# Main Game Loop
loop do
  delear_card_attribution(DEALER_HAND)
  player_card_attribution(PLAYER_HAND, player_name)
  display_dealer_hand(DEALER_HAND)
  display_player_hand(PLAYER_HAND, player_name)
  puts ''


  loop do
    prompt("#{player_name}, do you hit(h) or stay(s)?")
    answer = gets.chomp.downcase
    if answer == 'hit' || answer == 'h'
      PLAYER_HAND << CARD_DECK.sample
      puts "Here is your cards #{PLAYER_HAND}"
      if player_busted?(PLAYER_HAND, CARD_VALUE, player_name)
        refresh_screen
        puts "Your hand is #{PLAYER_HAND}"
        puts "Your score is #{calculate_player_hand(PLAYER_HAND, CARD_VALUE, player_name)}"
        puts "Sorry #{player_name}, You bust and I win"
        break
      end
    elsif answer == 'stay' || answer == 's'
      refresh_screen
      puts "Ok #{player_name}, now is Dealer's turn"
      loop do
        DEALER_HAND << CARD_DECK.sample
        if calculate_delear_hand(DEALER_HAND, CARD_VALUE) > TWENTY_ONE
          refresh_screen
          puts "My deck card is #{DEALER_HAND}"
          puts "My score is #{calculate_delear_hand(DEALER_HAND, CARD_VALUE)}"
          puts "Bravo #{player_name}, I bust and You win"
          break
        elsif calculate_delear_hand(DEALER_HAND, CARD_VALUE) >= 17
          break
        end
      end
      break
    else
      puts 'Please enter a correct answer: hit(h) or stay(s).'
    end
  end

  loop do
    break if calculate_player_hand(PLAYER_HAND, CARD_VALUE, player_name) > TWENTY_ONE
    break if calculate_delear_hand(DEALER_HAND, CARD_VALUE) > TWENTY_ONE
    puts ''
    puts "Your hand is #{PLAYER_HAND}"
    puts "You score is #{calculate_player_hand(PLAYER_HAND, CARD_VALUE, player_name)}"
    puts ''
    puts "My hand is #{DEALER_HAND}"
    puts "My score is #{calculate_delear_hand(DEALER_HAND, CARD_VALUE)}"
    puts ''
    if calculate_delear_hand(DEALER_HAND, CARD_VALUE) > calculate_player_hand(PLAYER_HAND, CARD_VALUE, player_name)
      puts 'Dealer won'
    elsif
      calculate_delear_hand(DEALER_HAND, CARD_VALUE) < calculate_player_hand(PLAYER_HAND, CARD_VALUE, player_name)
      puts 'Congratulations! You won'
    elsif calculate_delear_hand(DEALER_HAND, CARD_VALUE) == calculate_player_hand(PLAYER_HAND, CARD_VALUE, player_name)
      puts "It's a tie"
    end
    break
  end

  loop do
    puts 'Do you want to challenge your luck again (y/n)?'
    continue = gets.chomp.downcase
    if continue == 'yes' || continue == 'y'
      refresh_screen
      break
    elsif continue == 'no' || continue == 'n'
      puts 'Many thanks. Hope to see you again in our casino.'
      exit
    else
      puts 'Please enter a correct answer (Yes or y, No or n)'
    end
  end
PLAYER_HAND.clear
DEALER_HAND.clear
end
