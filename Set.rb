# File created 09/04/2019 by Sri Ramya Dandu
# Edited 09/05/2019 by Leah Gillespie
# Edited 09/06/2019 David Wing
# Edited 09/06/2019 by Neel Mansukhani
# Edited 09/07/2019 by Sharon Qiu
# Edited 09/07/2019 by Neel Mansukhani
# Edited 09/07/2019 by Sri Ramya Dandu
# Edited 09/08/2019 by Sharon Qiu
# Edited 09/08/2019 by Neel Mansukhani
# Edited 09/09/2019 by David Wing
# Edited 09/09/2019 by Sharon Qiu
# Edited 09/09/2019 by David Wing
# Edited 09/09/2019 by Sri Ramya Dandu
# Edited 09/10/2019 by Sri Ramya Dandu
# Edited 09/12/2019 by Leah Gillespie
# Edited 09/12/2019 by David Wing
# Edited 09/14/2019 by Neel Mansukhani
# Edited 09/15/2019 by Sri Ramya Dandu



# TODO: Add file description for every file.
# TODO: Multi line comments for function descriptions.
<<<<<<< HEAD
require_relative "Card"
=======
# Created 09/05/2019 by Leah Gillespie
# Edited 09/06/2019 by Neel Mansukhani: Added id and set_id function to Card
# Edited 09/10/2019 by David Wing: Added id to initialize.
# Edited 09/14/2019 by Neel Mansukhani: Added attribute accessor.
class Card

  attr_accessor :id, :number, :color, :shape, :shade

  # Created 09/05/2019 by Leah Gillespie
  # Edited 09/10/2019 by David Wing: Added id
  # Edited 09/15/2019 by Sri Ramya Dandu: Added documentation

  # Creates a new instance of Card with the given attributes
  def initialize(id, number, color, shape, shade)
    @id = id
    @number = number
    @color = color
    @shape = shape
    @shade = shade
  end

  # Created 09/05/2019 by Neel Mansukhani
  # Edited 09/06/2019 by Neel Mansukhani: Cleaned up display
  # Edited 09/15/2019 by Sri Ramya Dandu: Added documentation

  # Prints out the cards attributes
  def display
    print("Card: #{@id} ")
    print("Number: #{@number} ")
    print("Color: #{@color} ")
    print("Shape: #{@shape} ")
    puts("Shade: #{@shade}")
  end
end
>>>>>>> e11d2858e7c13271aa4a8084af59c2e24346289a

# Created 09/12/2019 by Leah Gillespie
# TODO: Add documentation for the class and each function
class AllTimers
  attr_reader :current
  def initialize
    @initial = Time.now
    @current = 0
  end
  def updateTime
    @current = Time.now - @initial
  end
  def reset
    @initial = Time.now
  end
end


# Created 09/06/2019 by Neel Mansukhani
# Edited 09/07/2019 by Sharon Qiu: Added in playingCards parameter and boolean value. Method now updates the showing cards.
# Edited 09/08/2019 by Sharon Qiu: Added in checks for situations to deal cards. Removed boolean value.
# Edited 09/09/2019 by Sri Ramya Dandu: changed deck and cardsShowing to a global variable


# Updates the passed in array of playingCards to a playable status for the player.
# Does nothing if deck of unplayed cards is empty.
# @updates playingCards
def dealCards(deck,cardsShowing)
  return if deck.length == 0

  #initializing deck.
  if cardsShowing.length == 0
    for count in 0...12
      card = deck.delete_at(rand(deck.length))
      cardsShowing.push(card)
    end
    return
  end

  if valid_table(cardsShowing).length == 0
    #continually adds cards until there is a set or there are no more cards.
    while (valid_table(cardsShowing).length == 0) && deck.length > 0
      #print("\n Empty: #{(valid_table(playingCards)).length == 0} \n")
      for count in 0...3
        card = deck.delete_at(rand(deck.length))
        cardsShowing.push(card)
      end
    end
  elsif cardsShowing.length < 12
    # Adds cards if there is a set but less than 12 playing cards.
    for count in 0...3
      card = deck.delete_at(rand(deck.length))
      cardsShowing.push(card)
    end

  end

end

# Created 09/05/2019 by Leah Gillespie
# Edited 09/06/2019 by Neel Mansukhani: Moved code to function.
# Edited 09/09/2019 by Sri Ramya Dandu: Changed deck to a global variable.
# Edited 09/12/2019 by Leah Gillespie: Made sure to use terse code.
# Edited 09/12/2019 by David Wing: Added id to be initialized.
# Edited 09/14/2019 by Neel Mansukhani: Made deck a local variable.

# Creates an array to be the deck and initializes 81 unique cards into it
def createDeck
  deck = Array.new
  id = 0
  for number in 0..2
    for color in 0..2
      for shape in 0..2
        for shade in 0..2
          deck.push Card.new(id, number,color,shape,shade)
          id += 1
        end
      end
    end
  end
  return deck
end

# Created 09/06/2019 by Neel Mansukhani
# Edited 09/15/2019 by Sri Ramya Dandu: added function back to the file
#
# Returns card from an array with the given id
# Returns card from the total deck with the given id
def getCardById(deck,id)
  deck.each do |card|
    return card if card.id == id
  end
end

# Created 09/04/2019 by Sri Ramya Dandu
# Edited 09/07/2019 by Sri Ramya Dandu: Optimized the checking method - made function concise
#   Checks if the 3 cards are a valid set or not. To be a valid set, all 3 cards must either have the same
#   attribute or all different attributes for each of the following attributes: number, color,shape,shade.
#   @param card1, card2, card3 to evaluate whether they form a set or not
#   @returns true if cards form a valid set, false otherwise
#   @updates $score
def isASet?(cards)
  # The sum when adding one number 3 times or adding 3 consecutive numbers is divisible by 3.
  # This represents having all the same attribute or all different attributes.
  # Adding any other 3 number combo of 1,2,3 will result in a value not divisible by 3, failing to be a set.
  (cards[0].number + cards[1].number + cards[2].number) % 3 == 0 &&
      (cards[0].color + cards[1].color + cards[2].color) % 3 == 0 &&
      (cards[0].shape + cards[1].shape + cards[2].shape) % 3 == 0 &&
      (cards[0].shade + cards[1].shade + cards[2].shade) % 3 == 0
end

# Created 09/06/2019 by David Wing
# Edited 09/07/2019 by David Wing
# Edited 09/08/2019 by David Wing
# Edited 09/09/2019 by Sri Ramya Dandu: changed cardsShowing to a global variable
# Edited 09/12/2019 by David Wing: Optimized table searching
# Given an Array of the displayed cards, checks if there is a set
# Returns an empty Array if there is not a set. If there is  set, it returns
# an array holding the 3 cards that form the set
def valid_table(cardsShowing)

  # make hash of all table cards
  # id is the key, location is the value
  tableHash =  Hash.new
  if cardsShowing.length < 1
    return []
  end

  for i in 0...cardsShowing.length
    tableHash[cardsShowing[i].id] = i
  end

  for card1 in 0...cardsShowing.length
    for card2 in 1...cardsShowing.length
      if(card1 == card2) #skip if same card
        next
      end

      # Find attributes of the last card needed
      # TODO: Make 1 line?
      # TODO: Explain this shit
      cardToFind = 27 * ((6- cardsShowing[card1].number - cardsShowing[card2].number) % 3)
      cardToFind += 9 * ((6- cardsShowing[card1].color - cardsShowing[card2].color) %3)
      cardToFind += 3 * ((6- cardsShowing[card1].shape - cardsShowing[card2].shape) %3)
      cardToFind += (6-cardsShowing[card1].shade - cardsShowing[card2].shade) %3

      # cardToFind is now the card ID for the last card
      if tableHash.include?(cardToFind)
        return [card1, card2, tableHash[cardToFind]]
      end

    end
  end

  return []
end


# Created 09/13/2019 by David Wing: Moved functionality to its own method.
# Given a valid set from the table, outputs two cards that make up a set
# Returns array of two card objects that are the hint
def get_hint(valid_set, cardsShowing)
  puts("look for a pair with these cards: ")
  puts("card " + cardsShowing[valid_set[0]].id.to_s + " and card " + cardsShowing[valid_set[1]].id.to_s)
  # TODO: Remove before submitting.
  #puts("card 3:" + cardsShowing[valid_set[2]].id.to_s) #DEBUG message
  # TODO: Terse code?
  return( [cardsShowing[valid_set[0]], cardsShowing[valid_set[1]] ])
  # Decrease score because you cheated
  $playerScore -= 0.5
end




# Created 09/08/2019 by Sri Ramya Dandu
# Edited 09/09/2019 by Sri Ramya Dandu: Update and display deck and scores
# Edited 09/09/2019 by Sri Ramya Dandu: Modifed so that the computer can guess wrong sets too
# Edited 09/15/2019 by Sri Ramya Dandu: Added levels of difficulty
# Edited 09/15/2019 by Sri Ramya Dandu: changed arrays back to local variables  
# TODO: Give CPU random name by generator
def computerPlayer(deck, cardsShowing)
  # Repeats execution in thread
  while true

    #ensure that the player thread is not printing the cards
    if($signal)
      indexSet = Array.new

      #generates 3 card index values
      winOrLose = rand(0..$range)
      if winOrLose % 3 == 0
        #will always return 3 values that form a set
        indexSet = valid_table(cardsShowing);
      else
        indexSet = (0...cardsShowing.length).to_a.sample(3)
      end

      card1 = cardsShowing[indexSet[0]]
      card2 = cardsShowing[indexSet[1]]
      card3 = cardsShowing[indexSet[2]]

      # Output for Computer Player
      # TODO: Replace puts with \n
      puts
      puts
      puts "--------------------Computer Took A Turn------------------"
      puts "Computer Player: I chose Card #{card1.id}, Card #{card2.id}, and Card #{card3.id}"

      if(isASet?([card1,card2,card3]))
        puts("That is a set!")
        $computerScore += 1
        cardsShowing.delete(card1)
        cardsShowing.delete(card2)
        cardsShowing.delete(card3)
      else
        puts("That is not a set.")
        $computerScore  -= 1
      end

      puts("Computer score: #{$computerScore}")
      puts("Your current score: #{$playerScore}")
      puts "--------------------Computer Finished Turn------------------"
      puts
      puts

      #changes signal to false to prevent player thread from printing it's cards
      $signal = false
      dealCards(deck,cardsShowing)
      cardsShowing.each{ |card| card.display }
      $signal = true
    end

    #thread sleeps for a variable interval of time
    sleep(rand(40...$range))
  end
end

#Created 09/08/2019 by Sri Ramya Dandu
#Edited 09/12/2019 by Leah Gillespie: Adding player statistics
# Edited 09/15/2019 by Sri Ramya Dandu: changed arrays back to local variables
def player(deck,cardsShowing)

  dealCards(deck,cardsShowing)
  sets = Array.new
  while true

    #changes signal to false to prevent computer thread from printing its cards
    $signal = false
    dealCards(deck,cardsShowing)

    #Displays cards
    cardsShowing.each { |card| card.display }
    $signal = true

    valid_set = valid_table(cardsShowing)

    # no valid sets
    break if valid_set.length == 0 && deck.length == 0

    # No checks for valid input because we plan to implement a GUI.


    print("Need a hint? y/n: ")
    input = gets.chomp
    if input.eql? "y"
      $p1Hints += 1
      get_hint(valid_set,cardsShowing)
    end

    print("Enter your 3 card numbers, separated by a comma: ")
    strInput = gets
    comma = strInput.index(",")
    card1 = strInput[0,comma].to_i
    strInput = strInput[comma+1,strInput.length]
    comma = strInput.index(",")
    card2 = strInput[0,comma].to_i
    strInput = strInput[comma+1,strInput.length]
    card3 = strInput[0,strInput.length].to_i
    set = [getCardById(cardsShowing,card1),getCardById(cardsShowing,card2),getCardById(cardsShowing,card3)]

    if(isASet?(set))
      $p1SetTimer.updateTime
      $p1SetTimes.push $p1SetTimer.current
      puts "That is a set!"
      #TODO: Score should increment/decrement here
      $playerScore += 1
      #TODO: set up hash or something to clean sets up.
      sets.push(set)
      $p1SetTimes.sort!
      puts "Fastest time to find a set: #{$p1SetTimes.at(0)}"
      puts "Slowest time to find a set: #{$p1SetTimes.at($p1SetTimes.length-1)}"
      avgTime = 0
      $p1SetTimes.each {|time| avgTime += time}
      avgTime = avgTime / $p1SetTimes.length
      puts "Average time to find a set: #{avgTime}"
      puts "Hints used so far: #{$p1Hints}"
      $p1SetTimer.reset
      cardsShowing.delete(set[0])
      cardsShowing.delete(set[1])
      cardsShowing.delete(set[2])
    else
      puts "That is not a set."
      $playerScore -= 1
    end

    puts "Computer score: #{$computerScore}"
    puts "Your current score: #{$playerScore}"
    $gameTimer.updateTime
    puts "Total elapsed time: #{$gameTimer.current}"
  end
end


# Acts as the beginning of what would be the main method in Java
# Edited 09/07/2019 by Neel Mansukhani: Testing fix
# Edited 09/08/2019 by Sharon Qiu: Cleaned up main checking conditions for dealing cards.
# Edited 09/08/2019 by Neel Mansukhani: Made score local variable instead of global
# Edited 09/08/2019 by Sharon Qiu: Fixed when cards should be displayed.
# Edited 09/09/2019 by Sharon Qiu: Added comment regarding checks for valid input.
# Edited 09/08/2019 by Neel Mansukhani: Made score local variable instead of global
# Edited 09/08/2019 by Sharon Qiu: Fixed when cards should be displayed.
# Edited 09/08/2019 by David Wing: Added hint implementation
# Edited 09/09/2019 by Sri Ramya Dandu: Display score changes
# Edited 09/09/2019 by Sri Ramya Dandu: added global variable and changed method of input
# Edited 09/12/2019 by Leah Gillespie: set up a timer for the game
# Edited 09/15/2019 by Sri Ramya Dandu: added levels of difficulty
# Edited 09/15/2019 by Sri Ramya Dandu: changed arrays back to local variables
#=========================== MAIN ==================================================

#global variables defined for data that is shared between the computer and the player

$playerScore,$computerScore = 0,0

# Timer for the entire game, from as close to initial deal as possible until game ends, should be displayed in GUI
# and will need to be updated regularly
$gameTimer = AllTimers.new
# This timer tracks the time it took player 1 to achieve the current set
$p1SetTimer = AllTimers.new
# This keeps track of all times for each set player 1 finds, in order from fastest to slowest
$p1SetTimes = Array.new
# This tracks how many hints player 1 has requested
$p1Hints = 0


# Boolean used to communicate between threads to prevent interruptions while printing cards
$signal = false



deck = createDeck
cardsShowing = Array.new
puts "Enter 1 to play solo, or 2 to play vs Computer"
choice = gets.to_i
if choice == 1
  player(deck, cardsShowing)
elsif choice == 2

  print "Choose a mode of difficulty (e/m/h): "
  mode = gets

<<<<<<< HEAD
    # Creating thread for the computer execution
    computerThread = Thread.new{computerPlayer}

    playerThread.join
    computerThread.join
  end
end
=======
  case mode
  when 'm'
    $range = 75
  when 'h'
    $range = 50
  else
    $range = 100
  end
  # Creating thread for the player execution
  playerThread = Thread.new{player(deck, cardsShowing)}

  # Creating thread for the computer execution
  computerThread = Thread.new{computerPlayer(deck, cardsShowing)}

  playerThread.join
  computerThread.join
end
>>>>>>> e11d2858e7c13271aa4a8084af59c2e24346289a
