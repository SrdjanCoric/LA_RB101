require 'yaml'
MSG = YAML.load_file('roscipalisp_messages.yml')

VALID_CHOICE = %w(rock paper scissors lizard spock)
ABBREVIATION_CHOICE = %w(r p sc l sp)

MOVES = { 'rock' => { 'abbr' => 'r', 'beats' => ['scissors', 'lizard'] },
          'paper' => { 'abbr' => 'p', 'beats' => ['rock', 'spock'] },
          'scissors' => { 'abbr' => 'sc', 'beats' => ['paper', 'lizard'] },
          'lizard' => { 'abbr' => 'l', 'beats' => ['spock', 'paper'] },
          'spock' => { 'abbr' => 'sp', 'beats' => ['scissors', 'rock'] } }

COMPUTER_WIN_MESSAGES = ['IN YOUR FACE', 'HAHA LOOSER!', 'I AM INVINCIBLE']
COMPUTER_LOSS_MESSAGES = ['Arf lucky!', 'Do not underestimate me!', 'NOOOO!']
COMPUTER_TIE_MESSAGES = ['...', 'Come on!', 'Fate is on your side kid']

def prompt(message)
  puts("=> #{message}")
end

def player_win?(player, computer)
  # PLAYER_MOVES[player].include?(computer)
  MOVES[player]['beats'].include?(computer)
end

def computer_win?(computer, player)
  # PLAYER_MOVES[computer].include?(player)
  MOVES[computer]['beats'].include?(player)
end

def abbreviation_to_word(input)
  if input == (MOVES['rock']['abbr'])
    input = 'rock'
  elsif input == (MOVES['paper']['abbr'])
    input = 'paper'
  elsif input == (MOVES['scissors']['abbr'])
    input = 'scissors'
  elsif input == (MOVES['lizard']['abbr'])
    input = 'lizard'
  elsif input == (MOVES['spock']['abbr'])
    input = 'spock'
  end
end

def display_results(player, computer)
  if player_win?(player, computer)
    prompt(COMPUTER_LOSS_MESSAGES.sample.to_s)
  elsif computer_win?(computer, player)
    prompt(COMPUTER_WIN_MESSAGES.sample.to_s)
  else
    prompt(COMPUTER_TIE_MESSAGES.sample.to_s)
  end
end

prompt(MSG['welcome_1'])
prompt(MSG['welcome_2'])
prompt(MSG['welcome_3'])
prompt(MSG['welcome_4'])
prompt(MSG['welcome_5'])
puts '-------------------------'
puts '-------------------------'

choice = ''
answer = ''
player_score = 0
computer_score = 0

prompt("Do you want to use plain (1) word or (2) abbreviation?: choose 1 or 2")
answer = gets.chomp.to_i
  if answer == 1
    loop do
          prompt("Choose one: #{VALID_CHOICE.join(', ')}")
          choice = gets.chomp.downcase
          puts ' '
          puts ' '
          if VALID_CHOICE.include?(choice)
            break
          else
            prompt(MSG['valid_choice_error'])
          end
    end

  elsif answer == 2
    loop do
          prompt("Choose one: #{ABBREVIATION_CHOICE.join(', ')}")
          choice = gets.chomp.downcase
          puts ' '
          puts ' '
          if ABBREVIATION_CHOICE.include?(choice)
            abbreviation_to_word(choice)
            break
          else
            prompt(MSG['valid_choice_error'])
          end
    end
  else
    prompt(MSG['valid_choice_error'])
  end

loop do

  loop do
    if player_score == 5 || computer_score == 5
      loop do
        prompt(MSG['try_again'])
        answer = gets.chomp
        if answer.downcase == 'y'
          player_score = 0
          computer_score = 0
          system('clear') || system('cls')
          break
        elsif answer.downcase == 'n'
          prompt(MSG['try_again_no'])
          exit
        else
          prompt(MSG['try_again_error'])
        end
      end
    end

    computer_choice = VALID_CHOICE.sample
    system('clear') || system('cls')
    player_score += 1 if player_win?(choice, computer_choice)
    computer_score += 1 if computer_win?(computer_choice, choice)
    prompt("You chose: #{choice} and computer chose: #{computer_choice}")
    puts '-------------------------'
    prompt("You score: #{player_score} and computer: #{computer_score}")
    puts '-------------------------'
    display_results(choice, computer_choice)
    puts ' '
    puts ' '
  end
end
