# [Rock_Paper_Scissors_Lizard_Sock](https://launchschool.com/lessons/a0f3cd44/assignments/4f8be124)



### To use yaml file:

```ruby
require 'yaml'
MSG = YAML.load_file('roscipalisp_messages.yml')

#MSG will be to import messages from the corresponding file
```



### Method to prompt

```ruby
def prompt(message)
    puts "=> #{message}"
end
```



### put the conditional/logic into hashes

```ruby
def win?(player, computer)
  (player == 'rock' && computer == 'scissors') ||
    (player == 'paper' && computer == 'rock') ||
    (player == 'scissors' && computer == 'paper')
end
```

we can structure this in a better way, first create an array that encompass the choice

```ruby
# The key of the array could be the choice of player 1 and the value would the choice of player 2 when choice 1 > choice 2. For example one key of the arrray could be 'rock' and its corresponding values would be 'scissors'. 

# We will put the value in an array in order to be able to call the method #include?
# We need to create the array first. As it will be used and will not be modified we can assign it to a CONSTANT

PLAYER_MOVE = { 'rock' => ['Scissors'],
    			'paper' => ['rock']
    			'scissors' => ['paper'] }

# Now we create a method that assess whether player one wins

def player_win?(player, computer)
    PLAYER_MOVE[player].include?(computer)
end

# Return true if the choice of player one equals the key and choice of computer equals one of its -here, the key- value.

def computer_win?(computer, player)
    PLAYER_MOVE[computer].include?(player)
end

# Similar way of thinking here. Except that we are assessing the value of the key of the computer versus the value of the player. That is why we are switch the parameters.
    



```



### Use hashes to validate input

In the game we want the user to be able to enter 'rock' or 'r'

For the first possibility we built a array:

```ruby
CHOICE = %w(rock scissors paper)

# Then next we write a few line to get input from the user and validate it
# We are in a loop

prompt("Choose one: #{VALID_CHOICE.join(', ')}")
  choice = gets.chomp.downcase
    if VALID_CHOICE.include?(choice)
      break
    else
        prompt(MSG['valid_choice_error'])
    end
```

Now if we want the abbreviation to be taken into account we do the following

```ruby
CHOICE = %w(rock scissors paper)
# We create an Hash that associate the abbreviation as key and the word as value
ABBREVIATION = { 'r' => 'rock',
                        'p' => 'paper',
                        'sc' => 'scissors',
                        'sp' => 'spock',
                        'l' => 'lizard' }

# Then latter in the code we can write something like this

prompt("Choose one: #{VALID_CHOICE.join(', ')}")
  choice = gets.chomp.downcase
    if VALID_CHOICE.include?(choice)
      break
    elsif VALID_CHOICE.include?(ABBREVIATION[choice])
        choice = ABBREVIATION[choice]
        break
    else
        prompt(MSG['valid_choice_error'])
    end

# Let's decompose this

VALID_CHOICE.include?(ABBREVIATION[choice])
# We need to read this from right to let. Is the value of the key included in the array VALID_CHOICE. 

#If true we assign the variable choice to the value of key and we break the loop
choice = ABBREVIATION[choice]
break
```

