
#File created 09/04/2019 by Sri Ramya Dandu




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

