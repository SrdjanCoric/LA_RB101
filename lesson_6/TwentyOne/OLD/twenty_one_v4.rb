# require 'pry'

CARD_DECK = ['A', '2', '3',
             '4', '5', '6',
             '7', '8', '9',
             '10', 'J', 'Q',
             'K']
CARD_VALUE = {
              'A'=> 11, '2'=> 2, '3'=> 3,
              '4'=> 4, '5'=> 5, '6'=> 6,
              '7'=> 7, '8'=> 8, '9'=> 9,
              '10'=> 10, 'J'=> 10,
              'Q'=> 10, 'K'=> 10
              }
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

def card_attribution(card_hand)
  card_hand[0] = CARD_DECK.sample
  card_hand[1] = CARD_DECK.sample
end

def display_dealer_hand(card_hand)
  prompt("Dealer has #{card_hand[0]} and an unknown card")
end

def display_player_hand(card_hand, name)
  prompt("#{name} has #{card_hand[0]} and #{card_hand[1]}")
end

def joinor(arr, delimiter=', ', word='and')
  if arr.size == 2
      arr.join(" #{word} ")
  else
    arr[-1] = "#{word} #{arr.last}"
    arr.join(delimiter)
  end
end

def display_in_game_hand(card_hand)
  cards = []
  card_hand.each do |card|
    cards << card
  end
  joinor(cards)
end

def count_card_points(card_hand, card_value)
  hand_value = 0
  card_hand.each do |card|
    hand_value += card_value[card]
  end
  if hand_value > 21 && card_hand.include?('A')
    hand_value -= (card_hand.count('A') * 10)
    return hand_value
  else
    hand_value
  end
end

def is_busted?(card_hand, card_value)
  count_card_points(card_hand, card_value) > TWENTY_ONE
end

def who_wins?(dealer, player, card_value)
  if count_card_points(dealer, card_value) > count_card_points(player, card_value)
    'Dealer'
  elsif count_card_points(dealer, card_value) < count_card_points(player, card_value)
    'Player'
  else
    'Tie'
  end
end

def play_again?
  puts "-------------"
  prompt "Do you want to play again? (y or n)"
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

prompt("Welcome here and thank you for playing at Twenty_One an easier version of the BlackJack!")
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
      prompt("Your cards are #{display_in_game_hand(PLAYER_HAND)} for a value of #{count_card_points(PLAYER_HAND, CARD_VALUE)}")
    end

    break if ['stay', 's'].include?(answer) || is_busted?(PLAYER_HAND, CARD_VALUE)
  end

  if is_busted?(PLAYER_HAND, CARD_VALUE)
    refresh_screen
    puts '****************************'
    prompt("You have #{display_in_game_hand(PLAYER_HAND)} for a value of #{count_card_points(PLAYER_HAND, CARD_VALUE)}")
    puts '****************************'
    puts ''
    prompt("Sorry #{player_name}, You bust! I win!")
    puts''
    prompt("Would you like to continue?")
    play_again? ? next : break
  else
    prompt("Your total of points is #{count_card_points(PLAYER_HAND, CARD_VALUE)}")
  end

  loop do
    break if count_card_points(DEALER_HAND, CARD_VALUE) >= 17

    prompt("I hit.")
    DEALER_HAND << CARD_DECK.sample
    end


  if is_busted?(DEALER_HAND, CARD_VALUE)
    refresh_screen
    puts '****************************'
    prompt("My cards are #{display_in_game_hand(DEALER_HAND)} for an score of #{count_card_points(DEALER_HAND, CARD_VALUE)}")
    prompt('I bust! You won')
    puts '****************************'
    puts ''
    prompt('Would you like to continue?')
    play_again? ? next : break
  else
    prompt("My cards are #{display_in_game_hand(DEALER_HAND)} for an score of #{count_card_points(DEALER_HAND, CARD_VALUE)}")
  end

  prompt("Let's see now the results")
  puts ''
  puts '****************************'
  prompt("#{player_name} has #{display_in_game_hand(PLAYER_HAND)}, for #{count_card_points(PLAYER_HAND, CARD_VALUE)} points")
  prompt("I have #{display_in_game_hand(DEALER_HAND)}, for #{count_card_points(DEALER_HAND, CARD_VALUE)} points")
  puts '****************************'
  puts ''
  if who_wins?(DEALER_HAND, PLAYER_HAND, CARD_VALUE) == 'Dealer'
    prompt('I won!')
  elsif who_wins?(DEALER_HAND, PLAYER_HAND, CARD_VALUE) == 'Player'
    prompt('You won!')
  else
    prompt("It's a tie!")
  end

  play_again? ? next : break

  PLAYER_HAND.clear
  DEALER_HAND.clear

end

prompt('Thank you for having played with me at Twenty-One')