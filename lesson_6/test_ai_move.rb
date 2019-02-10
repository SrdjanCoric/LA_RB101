
EMPTY_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = '0'

WIN_MOVES = [[1, 2, 3], # Horizontal
             [4, 5, 6],
             [7, 8, 9],
             [1, 4, 7], # Vertical
             [2, 5, 8],
             [3, 6, 9],
             [1, 5, 9], # Diagonal
             [3, 5, 7]]

board = { 1=> '0', 2=> '0', 3=> ' ', 4=> 'X', 5=> ' ', 6=> ' ', 7=> ' ', 8=> ' ', 9=> ' ' }


def computer_defensive_move(brd)
  ai_move = WIN_MOVES.map do |line|
    if brd.values_at(*line).count(COMPUTER_MARKER) == 2
      brd.select { |k,v| line.include?(k) && v == ' ' }.keys.first
    end
  end
  ai_def_move = ai_move.compact
  ai_def_move[0]
end

p computer_defensive_move(board)

# def computer_offensive_move(brd)
#   WIN_MOVES.each do |line|
#     if brd.values_at(*line).count('COMPUTER_MARKER') == 2
#       move = brd.select{|k,v| line.include?(k) && v == EMPTY_MARKER }.keys.first
#     end
#     return move
#   end
#   nil
# end

# def computer_turn!(brd)
#   if computer_offensive_move(brd) != nil
#     brd[computer_offensive_move(brd)] = COMPUTER_MARKER
#   elsif computer_defensive_move(brd) != nil
#     brd[computer_defensive_move(brd)] = COMPUTER_MARKER
#   elsif brd[5] == EMPTY_MARKER
#     brd[5] = COMPUTER_MARKER
#   else
#     square = empty_squares(brd).sample
#     brd[square] = COMPUTER_MARKER
#   end
# end