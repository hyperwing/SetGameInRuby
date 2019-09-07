
# File created 09/04/2019 by Sri Ramya Dandu
# Edited 09/05/2019 by Leah Gillespie

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
def dealCards(deck,num)
  newCards = Array.new
  for count in 0...num
    card = deck.delete_at(rand(deck.length))
    card.set_id($cardCount)
    $cardCount += 1
    newCards.push(card)
  end
  return newCards
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
cardsShowing += dealCards(deck,12)
#Displays cards
cardsShowing.each { |card| card.display }

sets = Array.new
while true # TODO: check if there are any sets left
  # TODO: check if there are enough cards in the deck to deal.
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
    cardsShowing += dealCards(deck,3)
    cardsShowing.each { |card| card.display }
  else
    puts("That is not a set.")
  end
end

# Created 09/05/2019 by Leah Gillespie
# proves the deck has 81 unique cards and that they're all unique; will be changed into formal testing later
# deck.each { |card| puts card.display }
# puts deck.length