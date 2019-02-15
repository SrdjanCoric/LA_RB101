# require 'pry'

CARD_DECK = ['A', '2', '3',
             '4', '5', '6',
             '7', '8', '9',
             '10', 'J', 'Q',
             'K']
CARD_VALUE = { 'A' => 11, '2' => 2, '3' => 3,
               '4' => 4, '5' => 5, '6' => 6,
               '7' => 7, '8' => 8, '9' => 9,
               '10' => 10, 'J' => 10,
               'Q' => 10, 'K' => 10 }
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

def card_attribution(hand)
  hand[0] = CARD_DECK.sample
  hand[1] = CARD_DECK.sample
end

def display_dealer_hand(hand)
  prompt("Dealer has #{hand[0]} and an unknown card")
end

def display_player_hand(hand, name)
  prompt("#{name} has #{hand[0]} and #{hand[1]}")
end

def joinor(arr, delimiter = ', ', word = 'and')
  if arr.size == 2
    arr.join(" #{word} ")
  else
    arr[-1] = "#{word} #{arr.last}"
    arr.join(delimiter)
  end
end

def display_in_game_hand(hand)
  cards = []
  hand.each do |card|
    cards << card
  end
  joinor(cards)
end

def count_card_points(hand, value)
  hand_value = 0
  hand.each do |card|
    hand_value += value[card]
  end
  if hand_value > 21 && hand.include?('A')
    hand_value -= (hand.count('A') * 10)
    return hand_value
  else
    hand_value
  end
end

def busted?(hand, value)
  count_card_points(hand, value) > TWENTY_ONE
end

def who_wins?(dealer, player, value)
  if count_card_points(dealer, value) > count_card_points(player, value)
    'Dealer'
  elsif count_card_points(dealer, value) < count_card_points(player, value)
    'Player'
  else
    'Tie'
  end
end

def continue?
  puts "-------------"
  prompt("Do you want to play again? (y or n)")
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

prompt("Welcome here")
prompt("Thank you for playing at Twenty_One!")
puts ''
player_name = ''
loop do
  prompt('Please, tell me what is your name?')
  player_name = gets.chomp
  break if !invalid_name?(player_name)
  prompt('Please enter a correct name')
end

# Main Game Loop

loop do
  refresh_screen
  puts '   .....Dealer distributes the cards.....'
  card_attribution(DEALER_HAND)
  card_attribution(PLAYER_HAND)
  display_dealer_hand(DEALER_HAND)
  display_player_hand(PLAYER_HAND, player_name)

  loop do
    answer = ''
    loop do
      prompt("#{player_name}, do you want to hit(h) or stay(s)?")
      answer = gets.chomp.downcase
      break if ['hit', 'h', 'stay', 's'].include?(answer)
      prompt('Please enter a correct answer: hit(h) or stay(s).')
    end

    if ['hit', 'h'].include?(answer)
      refresh_screen
      prompt("#{player_name} hits.")
      PLAYER_HAND << CARD_DECK.sample
      puts ''
      prompt("Your cards are #{display_in_game_hand(PLAYER_HAND)}")
      prompt("You have #{count_card_points(PLAYER_HAND, CARD_VALUE)} points")
    end

    break if ['stay', 's'].include?(answer) || busted?(PLAYER_HAND, CARD_VALUE)
  end

  if busted?(PLAYER_HAND, CARD_VALUE)
    refresh_screen
    puts '****************************'
    prompt("Your cards are #{display_in_game_hand(PLAYER_HAND)}")
    prompt("You have #{count_card_points(PLAYER_HAND, CARD_VALUE)} points")
    puts '****************************'
    puts ''
    prompt("Sorry #{player_name}, You bust! I win!")
    puts''
    prompt("Would you like to continue?")
    continue? ? next : break
  else
    prompt("Your have #{count_card_points(PLAYER_HAND, CARD_VALUE)} points")
  end

  loop do
    break if count_card_points(DEALER_HAND, CARD_VALUE) >= 17

    DEALER_HAND << CARD_DECK.sample
  end

  if busted?(DEALER_HAND, CARD_VALUE)
    refresh_screen
    prompt("Dealer hits.")
    puts '****************************'
    prompt("My cards are #{display_in_game_hand(DEALER_HAND)}")
    prompt("My score is #{count_card_points(DEALER_HAND, CARD_VALUE)}")
    prompt('I bust! You won')
    puts '****************************'
    puts ''
    prompt('Would you like to continue?')
    continue? ? next : break
  else
    prompt("Dealer hits.")
    prompt("My cards are #{display_in_game_hand(DEALER_HAND)}")
    prompt("My score is #{count_card_points(DEALER_HAND, CARD_VALUE)}")
  end

  prompt("Let's see now the results")
  puts ''
  puts '****************************'
  prompt("#{player_name} has #{display_in_game_hand(PLAYER_HAND)}")
  prompt("You have #{count_card_points(PLAYER_HAND, CARD_VALUE)} points")
  prompt("My cards are #{display_in_game_hand(DEALER_HAND)}")
  prompt("My score is #{count_card_points(DEALER_HAND, CARD_VALUE)}")
  puts '****************************'
  puts ''
  if who_wins?(DEALER_HAND, PLAYER_HAND, CARD_VALUE) == 'Dealer'
    prompt('I won!')
  elsif who_wins?(DEALER_HAND, PLAYER_HAND, CARD_VALUE) == 'Player'
    prompt('You won!')
  else
    prompt("It's a tie!")
  end

  continue? ? next : break

  PLAYER_HAND.clear
  DEALER_HAND.clear
end
prompt('Thank you for having played with me at Twenty-One')
