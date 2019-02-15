# require 'yaml'
# MESSAGES = YAML.load_file('ttt.yml')

EMPTY_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = '0'
COMPUTER_WIN_MESSAGES = ["I am the best!", "BOUM! who's the boss?",
                         "Don't cry...losing happens!",
                         "You should go back working on
                         LaunchSchool Curiculum!"]
COMPUTER_LOST_MESSAGES = ["HOW DID YOU..? What a stupid game!",
                          "NANI!!!", "Impossible! You cheat!",
                          "Let's stop playing and YOU..!
                          Go working on LaunchSchool!"]
WIN_MOVES = [[1, 2, 3], # Horizontal
             [4, 5, 6],
             [7, 8, 9],
             [1, 4, 7], # Vertical
             [2, 5, 8],
             [3, 6, 9],
             [1, 5, 9], # Diagonal
             [3, 5, 7]]
SCORE = 5

def prompt(string)
  puts "=> #{string}"
end

def invalid_name?(input)
  /[0-9]/.match(input) || /[\s]/.match(input) || input.empty?
end

# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
def display_board(brd, score, name, player1, player2)
  system('clear')
  puts "***** TIC TAC TOE Playing Board *****"
  puts ""
  puts "   First player is   --> #{player1} "
  puts "   Second player is  --> #{player2} "
  puts ""
  puts "           |     |"
  puts "        #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "           |     |"
  puts "      -----+-----+-----"
  puts "           |     |"
  puts "        #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "           |     |"
  puts "      -----+-----+-----"
  puts "           |     |"
  puts "        #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "           |     |"
  puts ""
  puts "Scores: #{name}: #{score[:player]} | Computer: #{score[:computer]}"
  puts ""
end
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each do |num|
    new_board[num] = EMPTY_MARKER
  end
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == EMPTY_MARKER }
end

def joinor(array, sign = ',', word = 'or')
  string = ''
  if array.size == 2
    string << "#{array.shift} #{word} #{array.shift}"
  elsif array.size == 1
    string << array.last.to_s
  else
    loop do
      break if array.size == 1
      string << "#{array.shift} #{sign} "
    end
    string << "#{word} #{array.last}"
  end
end

def player_turn!(brd)
  square = nil
  answer = nil
  loop do
    prompt("Choose a square from #{joinor(empty_squares(brd), ',', 'or')}")
    answer = gets.chomp
    if answer.to_i.to_s != answer
      prompt('Please make a valid choice (choose and Integer)')
    else
      square = answer.to_i
      break if empty_squares(brd).include?(square)
    end
  end
  brd[square] = PLAYER_MARKER
end

def computer_defensive_move(brd)
  ai_move = WIN_MOVES.map do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 2
      brd.select do |square, marker| 
        line.include?(square) && marker == EMPTY_MARKER
      end
        .keys
        .first
    end
  end
  ai_def_move = ai_move.compact
  ai_def_move[0]
end

def computer_offensive_move(brd)
  ai_move = WIN_MOVES.map do |line|
    if brd.values_at(*line).count(COMPUTER_MARKER) == 2
      brd.select do |square, marker| 
        line.include?(square) && marker == EMPTY_MARKER
      end
        .keys
        .first
    end
  end
  ai_off_move = ai_move.compact
  ai_off_move[0]
end

def computer_turn!(brd)
  if !computer_offensive_move(brd).nil?
    brd[computer_offensive_move(brd)] = COMPUTER_MARKER
  elsif !computer_defensive_move(brd).nil?
    brd[computer_defensive_move(brd)] = COMPUTER_MARKER
  elsif brd[5] == EMPTY_MARKER
    brd[5] = COMPUTER_MARKER
  else
    square = empty_squares(brd).sample
    brd[square] = COMPUTER_MARKER
  end
end

def board_full?(brd)
  !brd.values.include?(EMPTY_MARKER)
end

def winner?(brd, name)
  !!check_winner(brd, name)
end

def check_winner(brd, name)
  WIN_MOVES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return name
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

# Intro

puts""
puts""
puts "             X0X --- TIC TAC TOE Game --- 0X0"
puts "**********************************************************************"
puts""
puts "  Welcome and thank you for playing TIC-TAC-TOE. Rules are simple. "
puts "  You are will play with the crossed (X). I will play with the cir-"
puts "  cles (O). The first one able to align three of his signs will win"
puts "  the match. However to be a true winner, we need to win 5 matches!"
puts "  We will randomly start the game. Indeed as I cannot throw a coin,"
puts "  the algorithm will decide ^_^ ! Enjoy the game."
puts""

# Initialisation

player_name = ''
board = ''
score = { player: 0, computer: 0 }

loop do
  prompt('Please enter your name')
  player_name = gets.chomp
  if invalid_name?(player_name)
    prompt('Hmmm. Please enter a valid name. No number or weird character!')
  else
    break
  end
end

loop do
  player_choice = ["Computer", player_name]
  first_player = player_choice.sample
  second_player = player_choice - [first_player]
  second_player = second_player[0]
  board = initialize_board
  display_board(board, score, player_name, first_player, second_player)

  # Main Game Loop

  loop do
    if first_player == player_name
      player_turn!(board)
      display_board(board, score, player_name, first_player, second_player)
      break if check_winner(board, player_name) || board_full?(board)
      computer_turn!(board)
      display_board(board, score, player_name, first_player, second_player)
      break if check_winner(board, player_name) || board_full?(board)
    elsif first_player == 'Computer'
      computer_turn!(board)
      display_board(board, score, player_name, first_player, second_player)
      break if check_winner(board, player_name) || board_full?(board)
      player_turn!(board)
      display_board(board, score, player_name, first_player, second_player)
      break if check_winner(board, player_name) || board_full?(board)
    end
  end

  if check_winner(board, player_name) == player_name
    score[:player] += 1
  elsif check_winner(board, player_name) == 'Computer'
    score[:computer] += 1
  end

  if score[:computer] == SCORE
    display_board(board, score, player_name)
    prompt(COMPUTER_WIN_MESSAGES.sample)
    exit
  elsif score[:player] == SCORE
    display_board(board, score, player_name)
    prompt(COMPUTER_LOST_MESSAGES.sample)
    exit
  end

  if winner?(board, player_name)
    prompt("#{check_winner(board, player_name)} won!")
  else
    prompt("It is a tie")
  end

  loop do
    prompt("#{player_name}, do you want to continue?")
    answer = gets.chomp.downcase
    if answer == 'y' || answer == 'yes'
      prompt("Ok! let's go!")
      break
    elsif answer == 'n' || answer == 'no'
      system('clear')
      prompt('Bye bye, thank you for playing!')
      exit
    else
      system('clear')
      prompt("Please enter 'yes' or 'no'.")
    end
  end
end
