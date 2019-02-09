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
WIN_MOVES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +  # Horizontal
            [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +  # Vertical
            [[1, 5, 9], [3, 5, 7]]               # Diagonal

def prompt(string)
  puts "=> #{string}"
end

def invalid_name?(input)
  /[0-9]/.match(input) || /[\s]/.match(input) || input.empty?
end

# rubocop:disable Metrics/LineLength
# rubocop:disable Metrics/AbcSize
def display_board(brd, score, name)
  system('clear')
  puts "***** TIC TAC TOE Playing Board *****"
  puts ""
  puts "    #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}" + "    |     Scores"
  puts "  -----+-----+-----" + "  |"
  puts "    #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}" + "    | #{name}: #{score[:player]}"
  puts "  -----+-----+-----" + "  | Computer: #{score[:computer]}"
  puts "    #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}" + "    |"
  puts ""
end
# rubocop:enable Metrics/LineLength
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
    string << array.shift.to_s + ' ' + word << ' ' + array.shift.to_s
  elsif array.size == 1
    string << array.last.to_s
  else
    loop do
      break if array.size == 1
      string << (array.shift.to_s + sign + ' ')
    end
    string << word + ' ' + array.last.to_s
  end
end

def player_turn!(brd)
  square = ''
  loop do
    # prompt("Choose a square from #{empty_squares(brd).join(', ')}")
    prompt("Choose a square from #{joinor(empty_squares(brd), ',', 'or')}")
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt('Please make a valid choice')
  end
  brd[square] = PLAYER_MARKER
end

def computer_turn!(brd)
  square = empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  brd.values.include?(EMPTY_MARKER) ? false : true
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

player_name = ''
board = ''
score = { player: 0, computer: 0 }
puts""
puts""
puts "             X0X --- TIC TAC TOE Game --- 0X0"
puts "**********************************************************************"
puts "Welcome fellows! Now is the time to test your skills with my favourite
game! TIC TAC TOE! Rules are simple. You are the X and I am the cricles 'O'.
Try to align three 'X' before I align three 'O'. The first one who wins 5
games will be considered as the true winner. You can still decide to stop
before...but you will be considered as a looser for the rest of your life.
Good luck !"
puts""

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
  board = initialize_board
  display_board(board, score, player_name)

  loop do
    player_turn!(board)
    display_board(board, score, player_name)
    break if check_winner(board, player_name) || board_full?(board)
    computer_turn!(board)
    display_board(board, score, player_name)
    break if check_winner(board, player_name) || board_full?(board)
  end

  if check_winner(board, player_name) == player_name
    score[:player] += 1
  elsif check_winner(board, player_name) == 'Computer'
    score[:computer] += 1
  end

  if score[:computer] == 3
    display_board(board, score, player_name)
    prompt(COMPUTER_WIN_MESSAGES.sample)
    exit
  elsif score[:player] == 3
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
      prompt('Bye bye...LOOSER!')
      exit
    else
      system('clear')
      prompt("Please enter 'yes' or 'no'.")
    end
  end
end
