EMPTY_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = '0'

def prompt(string)
  puts "=> #{string}"
end

def display_board(brd)
  system('clear')
  puts ""
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "-----+-----+-----"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "-----+-----+-----"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts ""
end

def initialize_board
  new_board = {}
  (1..9).each do |num|
    new_board[num] = EMPTY_MARKER
  end
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == EMPTY_MARKER } # it selects keys that have a value = ' ' and puts them in an array
end

def player_turn!(brd)
  square = ''
  loop do
    prompt("Choose a square from #{empty_squares(brd).join(', ')}")
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

# def board_full?(brd)
#   brd.values.include?(' ') ? false : true
# end

def board_full?(brd)
  empty_squares == []
end
  

board = initialize_board
display_board(board)
  
loop do
  player_turn!(board)
  computer_turn!(board)
  display_board(board)
  break if board_full?(board)
end
  