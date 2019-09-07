
# File created 09/04/2019 by Sri Ramya Dandu
# Edited 09/05/2019 by Leah Gillespie
#Edited 9/06/19 David Wing
# Edited 09/07/2019 by Sharon Qiu

# Created 09/05/2019 by Leah Gillespie
# Edited 09/06/2019 by Neel Mansukhani
# Added id and set_id to Card
class Card

    attr_reader :id, :symbol, :color, :shape, :shade

    def initialize(symbol, color, shape, shade)
      @id = nil
      @symbol = symbol
      @color = color
      @shape = shape
      @shade = shade
    end
    # Edited 09/06/2019 by Neel Mansukhani
    # Cleaned up display
    def display
      print("Card: #{@id} ")
      print("Symbol: #{@symbol} ")
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
  for symbol in 0..2
    for color in 0..2
      for shape in 0..2
        for shade in 0..2
          deck.push(Card.new(symbol,color,shape,shade))
        end
      end
    end
  end
  return deck
end
# Created 09/04/2019 by Sri Ramya Dandu
=begin
    Checks if the 3 cards are a valid set or not. To be a valid set, all 3 cards must either have the same
    attribute or all different attributes for each of the following attrbitues: symbol, color,shape,shade.
    @param card1, card2, card3 to evaluate whether they form a set or not
    @returns true if cards form a valid set, false otherwise
    @updates $score
=end
def isASet?(cards)
    isSet = true

    # The sum when adding one number 3 times or adding 3 consecutive numbers is divisible by 3.
    # This represents having all the same attribute or all different attributes.
    # Adding any other 3 number combo of 1,2,3 will result in a value not divisible by 3, failing to be a set.
    isSet = false if (cards[0].symbol + cards[1].symbol + cards[2].symbol) % 3 != 0
    isSet = false if (cards[0].color + cards[1].color + cards[2].color) % 3 != 0
    isSet = false if (cards[0].shape + cards[1].shape + cards[2].shape) % 3 != 0
    isSet = false if (cards[0].shade + cards[1].shade + cards[2].shade) % 3 != 0
    $score += 1 if isSet
    return isSet
end

# Acts as the beginning of what would be the main method in Java
deck = createDeck
cardsShowing = Array.new
dealCards?(deck,cardsShowing,12)
#Displays cards
cardsShowing.each { |card| card.display }

sets = Array.new
while true # TODO: check if there are any sets left

  setExists = valid_table?(r1,r2,r3) #TODO: parameters need to be fixed
  noCardsLeft = (deck.length == 0)

  # Adds cards while no set exists and if there is cards left.
  while !setExists && !noCardsLeft
    noCardsLeft = dealCards?(deck,cardsShowing,3)
    setExists = valid_table?(r1,r2,r3) #TODO: parameters need to be fixed
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
deck.each { |card| puts card.display }
puts deck.length
# preliminary evidence that implementation and use of the deck array works with isASet? method
puts isASet?(deck.at(0), deck.at(1), deck.at(2))
puts isASet?(deck.at(1), deck.at(2), deck.at(3))


#Created 9/06/19 David Wing
# Create the DS for the table and set the table
row1 = []
row2 = []
row3 = []

# [][][][] + [additional cards]
# [][][][] + []
# [][][][] + []



#Created 9/06 David Wing
#Check if table is valid
def valid_table? (row1, row2, row3) #brute force check, but since there are only 12 cards to check its good enough
  for column_one in 0..row1.length
    for column_two in 0..row2.length
      for column_three in 0..row3.length
        if isASet(row1[column_one], row2[column_two], row3[column_three])
          return true
        end
      end
    end
  end
  return false
end
