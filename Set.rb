# File created 09/04/2019 by Sri Ramya Dandu
# Edited 09/05/2019 by Leah Gillespie
# Edited 9/06/2019 David Wing
# Edited 9/06/2019 by Neel Mansukhani
# Edited 09/07/2019 by Sharon Qiu
# Edited 9/07/2019 by Neel Mansukhani
# Edited 09/07/2019 by Sri Ramya Dandu
# Edited 09/08/2019 by Sharon Qiu

# Created 09/05/2019 by Leah Gillespie
# Edited 09/06/2019 by Neel Mansukhani
# Added id and set_id to Card
class Card

  #TODO Attribute matching to numbers

  #TODO check attributes are correct
  attr_reader :id, :number, :color, :shape, :shade

    def initialize(number, color, shape, shade)
      @id = nil
      @number = number
      @color = color
      @shape = shape
      @shade = shade
    end
    # Edited 09/06/2019 by Neel Mansukhani
    # Cleaned up display
    def display
      print("Card: #{@id} ")
      print("Number: #{@number} ")
      print("Color: #{@color} ")
      print("Shape: #{@shape} ")
      puts("Shade: #{@shade}")
    end

  def set_id(num)
    @id = num
  end
end

$score = 0
$cardCount = 0

# Created 09/06/2019 by Neel Mansukhani
# Returns card from an array with the given id
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
# Edited 09/06/2019 by Neel Mansukhani
# Moved code to function
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


#Created 9/06/19 David Wing
#updated 9/07-9/08 David Wing

#Given an Array of Table, Check if table is valid
# Returns Empty Array if not valid table, if valid table, returns Array of one Valid Set
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
          valid_set[0] = tableArray[card1]
          valid_set[1] = tableArray[card2]
          valid_set[2] = tableArray[card3]
          break
        end

      end
    end
  end
  
  return valid_set
end

# Acts as the beginning of what would be the main method in Java
# Edited 09/07/2019 by Neel Mansukhani
# Testing fix
# Edited 09/08/2019 by Sharon Qiu: Cleaned up main checking conditions for dealing cards.

#=========================== MAIN ==================================================
if __FILE__ == $0
deck = createDeck
cardsShowing = Array.new
dealCards(deck,cardsShowing)
#Displays cards
cardsShowing.each { |card| card.display }

sets = Array.new
while true # TODO: check if there are any sets left

  dealCards(deck,cardsShowing)

  break if ((valid_table(cardsShowing)).length == 0) && deck.length == 0

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
    #TODO: set up hash or something to clean sets up.
    sets.push(set)
    cardsShowing -= set
    cardsShowing.each { |card| card.display }
  else
    puts("That is not a set.")
    score -= 1
  end
end
end

# Created 09/05/2019 by Leah Gillespie
# proves the deck has 81 unique cards and that they're all unique; will be changed into formal testing later
# deck.each { |card| puts card.display }
# puts deck.length
# preliminary evidence that implementation and use of the deck array works with isASet? method
# puts isASet?(deck.at(0), deck.at(1), deck.at(2))
# puts isASet?(deck.at(1), deck.at(2), deck.at(3))
