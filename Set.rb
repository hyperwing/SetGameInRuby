# File created 09/04/2019 by Sri Ramya Dandu
# Edited 09/05/2019 by Leah Gillespie
# Edited 9/06/2019 David Wing
# Edited 9/06/2019 by Neel Mansukhani
# Edited 09/07/2019 by Sharon Qiu
# Edited 9/07/2019 by Neel Mansukhani
# Edited 09/07/2019 by Sri Ramya Dandu
# Edited 09/08/2019 by Sharon Qiu
# Edited 09/08/2019 by Neel Mansukhani
# Edited 09/09/2019 by David Wing
# Edited 09/09/2019 by Sri Ramya Dandu
require 'gosu'
require_relative 'StartScreen'
# Created 09/05/2019 by Leah Gillespie
# Edited 09/06/2019 by Neel Mansukhani: Added id and set_id function to Card
class Card

  #TODO Attribute matching to numbers

  #TODO check attributes are correct
  attr_reader :id, :number, :color, :shape, :shade

    # Created 09/05/2019 by Leah Gillespie
    def initialize(number, color, shape, shade)
      @id = nil
      @number = number
      @color = color
      @shape = shape
      @shade = shade
    end

    # Created 09/05/2019 by Neel Mansukhani
    # Edited 09/06/2019 by Neel Mansukhani: Cleaned up display
    def display
      print("Card: #{@id} ")
      print("Number: #{@number} ")
      print("Color: #{@color} ")
      print("Shape: #{@shape} ")
      puts("Shade: #{@shade}")
    end

    # Created 09/06/2019 by Neel Mansukhani
    def set_id(num)
     @id = num
    end
end

$cardCount = 0

# Created 09/06/2019 by Neel Mansukhani
# Returns card from the total deck with the given id
def getCardById(deck,id)
deck.each do |card|
  return card if card.id == id
end
return nil
end

# Created 09/06/2019 by Neel Mansukhani
# Removes 12 cards from deck.
# Edited 09/07/2019 by Sharon Qiu:
# Added in playingCards parameter. Method now updates the showing cards.
# Added in boolean value signifying an empty deck.
# Edited 09/08/2019 by Sharon Qiu:
# Added in checks for situations to deal cards.
# Removed boolean value.
# Wrote description for method.
#
# Updates the passed in array of playingCards to a playable status for the player.
# Does nothing if deck of unplayed cards is empty.
#
# @param deck, playingCards
# @updates playingCards
#
def dealCards(deck,playingCards)
  return if deck.length == 0

  #initializing deck.
  if playingCards.length == 0
    for count in 0...12
      card = deck.delete_at(rand(deck.length))
      card.set_id($cardCount)
      $cardCount += 1
      playingCards.push(card)
    end
    return
  end

  if (valid_table(playingCards)).length == 0
    #continually adds cards until there is a set or there are no more cards.
    while ((valid_table(playingCards)).length == 0) && deck.length > 0
      #print("\n Empty: #{(valid_table(playingCards)).length == 0} \n")
      for count in 0...3
        card = deck.delete_at(rand(deck.length))
        card.set_id($cardCount)
        $cardCount += 1
        playingCards.push(card)
      end
    end
  elsif playingCards.length < 12
    # Adds cards if there is a set but less than 12 playing cards.
    for count in 0...3
      card = deck.delete_at(rand(deck.length))
      card.set_id($cardCount)
      $cardCount += 1
      playingCards.push(card)
    end

  end

end

# Created 09/05/2019 by Leah Gillespie
# Edited 09/06/2019 by Neel Mansukhani: Moved code to function
#
# Creates an array to be the deck and initializes 81 unique cards into it
def createDeck
deck = Array.new
for number in 0..2
  for color in 0..2
    for shape in 0..2
      for shade in 0..2
        deck.push(Card.new(number,color,shape,shade))
      end
    end
  end
end
return deck
end

# Created 09/04/2019 by Sri Ramya Dandu
# Edited 09/07/2019 by Sri Ramya Dandu: Optimized the checking method - made function concise
=begin
  Checks if the 3 cards are a valid set or not. To be a valid set, all 3 cards must either have the same
  attribute or all different attributes for each of the following attributes: number, color,shape,shade.
  @param card1, card2, card3 to evaluate whether they form a set or not
  @returns true if cards form a valid set, false otherwise
  @updates $score
=end
def isASet?(cards)
  # The sum when adding one number 3 times or adding 3 consecutive numbers is divisible by 3.
  # This represents having all the same attribute or all different attributes.
  # Adding any other 3 number combo of 1,2,3 will result in a value not divisible by 3, failing to be a set.
  isSet = (cards[0].number + cards[1].number + cards[2].number) % 3 == 0 &&
      (cards[0].color + cards[1].color + cards[2].color) % 3 == 0 &&
      (cards[0].shape + cards[1].shape + cards[2].shape) % 3 == 0 &&
      (cards[0].shade + cards[1].shade + cards[2].shade) % 3 == 0
end

#Created 9/06/2019 by David Wing
#Edited 9/07/2019 by David Wing
#Edited 9/08/2019 by David Wing
#
# Given an Array of the displayed cards, checks if there is a set
# Returns an empty Array if there is not a set. If there is  set, it returns
# an array holding the 3 cards that form the set
def valid_table(tableArray)

  valid_set = Array[]
  for card1 in 0...tableArray.length
    for card2 in 0...tableArray.length
      if(card1 == card2) #skip if same card
        next
      end

      for card3 in 0...tableArray.length
        
        if card2 == card3 or card1 == card3 #skip if same card
          next
        end 

        if isASet?([tableArray[card1], tableArray[card2], tableArray[card3]])
          #found valid set
          valid_set[0] = card1
          valid_set[1] = card2
          valid_set[2] = card3
          break
        end

      end
    end
  end
  
  return valid_set
end

# Acts as the beginning of what would be the main method in Java
# Edited 09/07/2019 by Neel Mansukhani: Testing fix
# Edited 09/08/2019 by Sharon Qiu: Cleaned up main checking conditions for dealing cards.
# Edited 09/08/2019 by Neel Mansukhani: Made score local variable instead of global
# Edited 09/08/2019 by Sharon Qiu: Fixed when cards should be displayed.
# Edited 09/08/2019 by David Wing: Added hint implementation
# Edited 09/09/2019 by Sri Ramya Dandu: Display score changes
#=========================== MAIN ==================================================
if __FILE__ == $0
StartScreen.new.show
score = 0
deck = createDeck
cardsShowing = Array.new
dealCards(deck,cardsShowing)

sets = Array.new
while true 

  dealCards(deck,cardsShowing)

  #Displays cards
  cardsShowing.each { |card| card.display }

  valid_set = valid_table(cardsShowing);

  # no valid sets
  break if valid_set.length == 0 && deck.length == 0

  #HINT logic David Wing 9/9
  print("Need a hint? (Score will decrease by .5) y/n: ")
  input = gets.chomp
  if input.eql?("y") == true
    puts("look for a pair with these cards: ")
    puts("card " + cardsShowing[valid_set[0]].id.to_s + " and card " + cardsShowing[valid_set[1]].id.to_s)
    #puts("card 3:" + cardsShowing[valid_set[2]].id.to_s) #DEBUG message

    #decrease score because you cheated
    score -= 0.5
  end

  #not checking for correct input because with GUI implementation it will be unnecessary
  print("Enter your first card number: ")
  card1 = gets.to_i
  print("Enter your second card number: ")
  card2 = gets.to_i
  print("Enter your third card number: ")
  card3 = gets.to_i
  set = [getCardById(cardsShowing,card1),getCardById(cardsShowing,card2),getCardById(cardsShowing,card3)]
  if(isASet?(set))
    puts("That is a set!")
    #TODO: Score should increment/decrement here
    score += 1
    puts("Your current score: #{score}")
    #TODO: set up hash or something to clean sets up.
    sets.push(set)
    cardsShowing -= set
  else
    puts("That is not a set.")
    score -= 1
    puts("Your current score: #{score}")
  end
end
end