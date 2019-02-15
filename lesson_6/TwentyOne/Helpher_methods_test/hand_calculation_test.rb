# Test to calculate value of the hand

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
PLAYER_HAND = ['2', 'K']
DEALER_HAND = ['7', 'J']

PLAYER_HAND << CARD_DECK.sample

p PLAYER_HAND

hand_value = 0
PLAYER_HAND.each do |card|
  hand_value += CARD_VALUE[card]
end
p hand_value