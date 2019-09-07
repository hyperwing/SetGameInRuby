
# File created 09/04/2019 by Sri Ramya Dandu
# Edited 09/05/2019 by Leah Gillespie
# Edited 9/06/2019 David Wing
# Edited 9/06/2019 by Neel Mansukhani
# Edited 09/07/2019 by Sharon Qiu
# Edited 9/07/2019 by Neel Mansukhani

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
      print("number: #{@number} ")
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
def dealCards?(deck,playingCards,num)
  emptyDeck = false
  return true if deck.length == 0
  for count in 0...num
    card = deck.delete_at(rand(deck.length))
    card.set_id($cardCount)
    $cardCount += 1
    playingCards.push(card)
  end
  return emptyDeck
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
#TODO write tests for create deck


# Created 09/04/2019 by Sri Ramya Dandu
=begin
    Checks if the 3 cards are a valid set or not. To be a valid set, all 3 cards must either have the same
    attribute or all different attributes for each of the following attributes: number, color,shape,shade.
    @param card1, card2, card3 to evaluate whether they form a set or not
    @returns true if cards form a valid set, false otherwise
    @updates $score
=end
def isASet?(cards)
    isSet = true

    #TODO optimize checks
    # The sum when adding one number 3 times or adding 3 consecutive numbers is divisible by 3.
    # This represents having all the same attribute or all different attributes.
    # Adding any other 3 number combo of 1,2,3 will result in a value not divisible by 3, failing to be a set.
    isSet = false if (cards[0].number + cards[1].number + cards[2].number) % 3 != 0
    isSet = false if (cards[0].color + cards[1].color + cards[2].color) % 3 != 0
    isSet = false if (cards[0].shape + cards[1].shape + cards[2].shape) % 3 != 0
    isSet = false if (cards[0].shade + cards[1].shade + cards[2].shade) % 3 != 0
    $score += 1 if isSet
    return isSet
end

# Acts as the beginning of what would be the main method in Java
# Edited 09/07/2019 by Neel Mansukhani
# Testing fix
#=========================== MAIN ==================================================
if __FILE__ == $0
deck = createDeck
cardsShowing = Array.new
dealCards?(deck,cardsShowing,12)
#Displays cards
cardsShowing.each { |card| card.display }

sets = Array.new
while true # TODO: check if there are any sets left

  setExists = true#valid_table?(r1,r2,r3) TODO: parameters need to be fixed
  noCardsLeft = (deck.length == 0)

  # Adds cards while no set exists and if there is cards left.
  while !setExists && !noCardsLeft
    noCardsLeft = dealCards?(deck,cardsShowing,3)
    setExists = true#valid_table?(r1,r2,r3) TODO: parameters need to be fixed
  end

  break if (!setExists && noCardsLeft) || (cardsShowing.length == 0)

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

    #TODO: set up hash or something to clean sets up.
    sets.push(set)
    cardsShowing -= set
    if cardsShowing.length < 12
      dealCards?(deck,cardsShowing,3)
    end
    cardsShowing.each { |card| card.display }
  else
    puts("That is not a set.")
  end
end

# Created 09/05/2019 by Leah Gillespie
# proves the deck has 81 unique cards and that they're all unique; will be changed into formal testing later
# deck.each { |card| puts card.display }
# puts deck.length
# preliminary evidence that implementation and use of the deck array works with isASet? method
# puts isASet?(deck.at(0), deck.at(1), deck.at(2))
# puts isASet?(deck.at(1), deck.at(2), deck.at(3))


#Created 9/06/19 David Wing
# Create the DS for the table and set the table

row1 = []
row2 = []
row3 = []

# [][][][] + [additional cards]
# [][][][] + []
# [][][][] + []


end
#Created 9/06 David Wing
#updated 9/07 David Wing
#Check if table is valid

#TODO magic number doesnt make sense
def valid_table? (row1, row2, row3) 
  types = Hash.new(row3)

  for column_one in 0..row1.length
    for column_two in 0..row2.length

      card1 = row1[column_one]
      card2 = row2[column_two]

      #cardToFind = Card.new

      attrToFind = [6,6,6,6]
      # any two types are equal, the third must be equal
      # any two types are different, the third must be different

      #TODO add count

      #TODO explain magic

      #magic number = 6
      attrToFind[0] = 6 - card1.shape - card2.shape
      attrToFind[1] = 6 - card1.shade - card2.shade
      attrToFind[2] = 6- card1.number - card2.number
      attrToFind[3] = 6 - card1.color - card2.color

      until i > 4
        if attrToFind[i] ==4
          attrToFind[i] = 1
          
      cardToFind.shape = attrToFind[0]
      cardToFind.shade = attrToFind[1]
      cardToFind.number = attrToFind[2]
      cardToFind.color = attrToFind[3]


      #TODO add hash
      #if cardToFind


    end
  end
  return false
end
end end