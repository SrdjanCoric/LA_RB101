
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

p count_card_points(['A', 'A', '2', '3', '7'], CARD_VALUE)