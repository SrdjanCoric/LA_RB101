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
SCORE = 5

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

def busted?(total)
  total > TWENTY_ONE
end

def display_player_results(hand, total)
  prompt("Your cards are #{display_in_game_hand(hand)}")
  prompt("You have #{total} points")
end

def display_dealer_results(hand, total)
  prompt("My cards are #{display_in_game_hand(hand)}")
  prompt("I have #{total} points")
end

def who_wins?(dealer_total, player_total)
  if dealer_total > player_total
    'Dealer'
  elsif dealer_total < player_total
    'Player'
  else
    'Tie'
  end
end

def continue?
  prompt("Do you want to play again? (y or n)")
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

def check_tournament_winner(dealer, player)
  if player == SCORE
    prompt('Congratulations! You won the tournament!')
    exit
  elsif dealer == SCORE
    prompt('The Dealer won the tournament!')
    exit
  end
end

prompt("Welcome here")
prompt("Thank you for playing at Twenty_One!")
puts ''

player_name = ''
score = { player: 0, dealer: 0 }

loop do
  prompt('Please, tell me what is your name?')
  player_name = gets.chomp
  break if !invalid_name?(player_name)
  prompt('Please enter a correct name')
end

# Main Game Loop

loop do
  refresh_screen
  prompt("Scores: #{player_name}: #{score[:player]}, Dealer: #{score[:dealer]}")
  puts ''
  puts '   .....Dealer distributes the cards.....'
  puts ''
  card_attribution(DEALER_HAND)
  card_attribution(PLAYER_HAND)
  display_dealer_hand(DEALER_HAND)
  display_player_hand(PLAYER_HAND, player_name)
  player_total = count_card_points(PLAYER_HAND, CARD_VALUE)
  dealer_total = count_card_points(DEALER_HAND, CARD_VALUE)

  # Player_turn

  loop do
    answer = ''
    loop do
      prompt("#{player_name}, do you want to hit(h) or stay(s)?")
      answer = gets.chomp.downcase
      break if ['stay', 's', 'hit', 'h'].include?(answer)
      prompt('Please enter a correct answer: hit(h) or stay(s).')
    end

    if answer == 'hit' || answer == 'h'
      refresh_screen
      PLAYER_HAND << CARD_DECK.sample
      prompt("#{player_name} hits.")
      player_total = count_card_points(PLAYER_HAND, CARD_VALUE)
      display_player_results(PLAYER_HAND, player_total)
    end

    break if ['s', 'stay'].include?(answer) || busted?(player_total)
  end

  if busted?(player_total)
    refresh_screen
    puts '****************************'
    display_player_results(PLAYER_HAND, player_total)
    puts '****************************'
    puts ''
    prompt("Sorry #{player_name}, You bust! I win!")
    score[:dealer] += 1
    check_tournament_winner(score[:dealer], score[:player])
    puts''
    PLAYER_HAND.clear
    DEALER_HAND.clear
    continue? ? next : break
  else
    prompt("You decided to stay! Place your bets no more bets")
    display_player_results(PLAYER_HAND, player_total)
  end

  prompt("Dealer's turn!")
  puts ''
  loop do
    break if dealer_total >= 17

    DEALER_HAND << CARD_DECK.sample
    dealer_total = count_card_points(DEALER_HAND, CARD_VALUE)
  end

  if busted?(dealer_total)
    refresh_screen
    puts '****************************'
    display_dealer_results(DEALER_HAND, dealer_total)
    prompt('I bust! You won')
    score[:player] += 1
    check_tournament_winner(score[:dealer], score[:player])
    puts '****************************'
    puts ''
    PLAYER_HAND.clear
    DEALER_HAND.clear
    continue? ? next : break
  else
    display_dealer_results(DEALER_HAND, dealer_total)
  end

  prompt("Let's see now the results")
  puts ''
  puts '****************************'
  display_player_results(PLAYER_HAND, player_total)
  display_dealer_results(DEALER_HAND, dealer_total)
  puts '****************************'
  puts ''
  if who_wins?(dealer_total, player_total) == 'Dealer'
    prompt('I won!')
    score[:dealer] += 1
  elsif who_wins?(dealer_total, player_total) == 'Player'
    prompt('You won!')
    score[:player] += 1
  else
    prompt("It's a tie!")
  end

  check_tournament_winner(score[:dealer], score[:player])
  PLAYER_HAND.clear
  DEALER_HAND.clear
  continue? ? next : break
end
prompt('Thank you for having played with me at Twenty-One')
