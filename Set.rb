
#File created 09/04/2019 by Sri Ramya Dandu
# Edited 09/05/2019 by Leah Gillespie
#Edited 9/06/19 David Wing

#Created 09/05/2019 by Leah Gillespie
class Card

    attr_reader :symbol, :color, :shape, :shade

    def initialize(symbol, color, shape, shade)
        @symbol = symbol
        @color = color
        @shape = shape
        @shade = shade
    end

    def display
        print @symbol
        print @color
        print @shape
        print @shade
    end
end

$score = 0

# Created 09/04/2019 by Sri Ramya Dandu
=begin
    Checks if the 3 cards are a valid set or not. To be a valid set, all 3 cards must either have the same
    attribute or all different attributes for each of the following attrbitues: symbol, color,shape,shade.
    @param card1, card2, card3 to evaluate whether they form a set or not
    @returns true if cards form a valid set, false otherwise
    @updates $score
=end
def isASet?(card1, card2, card3)
    isSet = true

    # The sum when adding one number 3 times or adding 3 consecutive numbers is divisible by 3.
    # This represents having all the same attribute or all different attributes.
    # Adding any other 3 number combo of 1,2,3 will result in a value not divisible by 3, failing to be a set.
    isSet = false if (card1.symbol + card2.symbol + card3.symbol) % 3 != 0
    isSet = false if (card1.color + card2.color + card3.color) % 3 != 0
    isSet = false if (card1.shape + card2.shape + card3.shape) % 3 != 0
    isSet = false if (card1.shade + card2.shade + card3.shade) % 3 != 0
    $score += 1 if isSet
    isSet
end

#Created 09/05/2019 by Leah Gillespie
# creates an array to be the deck and initializes 81 unique cards into it
# Acts as the beginning of what would be the main method in Java
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

#Created 09/05/2019 by Leah Gillespie
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