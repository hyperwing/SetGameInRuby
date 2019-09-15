# File created 09/05/2019 by Neel Mansukhani
# Edited 09/05/2019 by Sri Ramya Dandu
# Edited 09/07/2019 by Sri Ramya Dandu
# Edited 09/08/2019 by Sharon Qiu
# Edited 09/08/2019 by David Wing
# Edited 09/08/2019 by Leah Gillespie
# Edited 09/09/2019 by David Wing

require_relative("../Set")

# Created 09/05/2019 by Sri Ramya Dandu
# Edited 09/07/2019 by Sri Ramya Dandu: changed the input to reflect input changes in method
#
# Tests for isASet? function
context "All 3 cards have the same attributes for all categories " do

  it "Returns true when all cards have attribute 1" do
    card1 = Card.new(40,1,1,1,1)
    card2 = Card.new(40,1,1,1,1)
    card3 = Card.new(40,1,1,1,1)
    set = [card1, card2, card3]

    expect(isASet?(set)).to eq(true)
  end

  it "Returns true when all cards have attribute 2" do
    card1 = Card.new(80,2,2,2,2)
    card2 = Card.new(80,2,2,2,2)
    card3 = Card.new(80,2,2,2,2)
    set = [card1, card2, card3]

    expect(isASet?(set)).to eq(true)
  end

  it "Returns true when all cards have attribute 3" do
    card1 = Card.new(0,0,0,0,0)
    card2 = Card.new(0,0,0,0,0)
    card3 = Card.new(0,0,0,0,0)
    set = [card1, card2, card3]

    expect(isASet?(set)).to eq(true)
  end
end

context "All cards have different attributes" do
  it "Returns true if 3 cards have the different attributes for all categories" do
    card1 = Card.new(29,1,0,0,2)
    card2 = Card.new(75,2,2,1,0)
    card3 = Card.new(16,0,1,2,1)
    set = [card1, card2, card3]

    expect(isASet?(set)).to eq(true)
  end
end

context "Cards are not valid sets" do
  it "returns false when 1 attribute requirement isn't met" do
    card1 = Card.new(32,1,0,1,2)
    card2 = Card.new(57,2,0,1,0)
    card3 = Card.new(7,0,0,2,1)
    set = [card1, card2, card3]

    expect(isASet?(set)).to eq(false)
  end

  it "returns false when 2 attribute requirements aren't met" do
    card1 = Card.new(32,1,0,1,2)
    card2 = Card.new(57,2,0,1,0)
    card3 = Card.new(8,0,0,2,2)
    set = [card1, card2, card3]

    expect(isASet?(set)).to eq(false)
  end

  it "returns false when 3 attribute requirements aren't met" do
    card1 = Card.new(32,1,0,1,2)
    card2 = Card.new(66,2,1,1,0)
    card3 = Card.new(8,0,0,2,2)
    set = [card1, card2, card3]

    expect(isASet?(set)).to eq(false)
  end

  it "returns false when all attribute requirements aren't met" do
    card1 = Card.new(32,1,0,1,2)
    card2 = Card.new(39,1,1,1,0)
    card3 = Card.new(8,0,0,2,2)
    set = [card1, card2, card3]

    expect(isASet?(set)).to eq(false)
  end
end

context "white box testing of the function to ensure each if statement works" do
  it "returns false when the symbol attribute requirement isn't met, but all others are met" do
    card1 = Card.new(32,1,0,1,2)
    card2 = Card.new(39,1,1,1,0)
    card3 = Card.new(17,0,1,2,2)
    set = [card1, card2, card3]

    expect(isASet?(set)).to eq(false)
  end

  it "returns false when the color attribute requirement isn't met, but all others are met" do
    card1 = Card.new(38,1,1,0,2)
    card2 = Card.new(50,1,2,1,2)
    card3 = Card.new(44,1,1,2,2)
    set = [card1, card2, card3]

    expect(isASet?(set)).to eq(false)
  end

  it "returns false when the shape attribute requirement isn't met, but all others are met" do
    card1 = Card.new(29,1,0,0,2)
    card2 = Card.new(47,1,2,0,2)
    card3 = Card.new(44,1,1,2,2)
    set = [card1, card2, card3]

    expect(isASet?(set)).to eq(false)
  end

  it "returns false when the shape attribute requirement isn't met, but all others are met" do
    card1 = Card.new(28,1,0,0,1)
    card2 = Card.new(47,1,2,0,2)
    card3 = Card.new(38,1,1,0,2)
    set = [card1, card2, card3]

    expect(isASet?(set)).to eq(false)
  end
end

# Created 09/08/2019 by Sharon Qiu
# Tests for dealCards method
context "No more unplayed cards in the deck left." do

  it "Does not add cards when cards showing is empty and deck of unplayed cards is empty." do
    $cardsShowing = []
    $deck = []
    dealCards()

    expect($cardsShowing.eql?([].to_a))
  end

  it "Does not add cards when there is a set and no more unplayed cards left." do
    card1 = Card.new(32,1,0,1,2)
    card2 = Card.new(47,1,2,0,2)
    card3 = Card.new(44,1,1,2,2)
    $cardsShowing = [card1, card2, card3]
    $deck = []
    dealCards

    expect($cardsShowing.eql?([card1, card2, card3].to_a))
  end

  it "Does not add cards when there is not a set and no more unplayed cards left." do
    card1 = Card.new(29,1,0,0,2)
    card2 = Card.new(47,1,2,0,2)
    card3 = Card.new(44,1,1,2,2)
    $cardsShowing = [card1, card2, card3]
    $deck = []
    dealCards

    expect($cardsShowing.eql?([card1, card2, card3].to_a))
  end
end

context "There is not a set in the current cards and there are cards unplayed left." do

  it "Adds cards when there are less than 12 playing cards and until there is a set in the set." do
    card1 = Card.new(29,1,0,0,2)
    card2 = Card.new(47,1,2,0,2)
    card3 = Card.new(35,1,0,2,2)
    card4 = Card.new(70,2,1,2,1)
    card5 = Card.new(0,0,0,0,0)
    card6 = Card.new(23,0,2,1,2)

    #all cards below are cards that can be added to form a set in the 6 cards above.
    card7 = Card.new(38,1,1,0,2)
    card8 = Card.new(21,0,2,1,0)
    card9 = Card.new(58,2,0,1,1)
    card10 = Card.new(3,0,0,1,0)
    card11 = Card.new(41,1,1,1,2)
    card12 = Card.new(16,0,1,2,1)
    $cardsShowing = [card1, card2, card3, card4, card5, card6]
    $deck = [card7, card8, card9,card10,card11,card12]
    dealCards

    expect($cardsShowing.length == 9)
  end

  it "Adds cards when there is no set but more than 12 cards played." do

    card1 = Card.new(0,0,0,0,0)
    card2 = Card.new(30,1,0,1,0)
    card3 = Card.new(27,1,0,0,0)
    card4 = Card.new(3,0,0,1,0)
    card5 = Card.new(9,0,1,0,0)
    card6 = Card.new(39,1,1,1,0)
    card7 = Card.new(36,1,1,0,0)
    card8 = Card.new(12,0,1,1,0)
    card9 = Card.new(19,0,2,0,1)
    card10 = Card.new(76,2,2,1,1)
    card11 = Card.new(74,2,2,0,2)
    card12 = Card.new(23,0,2,1,2)

    card13 = Card.new(60,2,0,2,0)
    card14 = Card.new(24,0,2,2,0)
    card15 = Card.new(78,2,2,2,0)
    $cardsShowing = [card1, card2, card3, card4, card5, card6, card7, card8, card9, card10,card11,card12]
    $deck = [card13,card14,card15]
    dealCards

    expect($cardsShowing.eql?([card1, card2, card3, card4, card5, card6, card7, card8, card9, card10, card11, card12,card13,card14,card15].to_a))
  end

end

context "There is a set, but less than 12 cards. There are also cards unplayed left." do

  it "Adds cards when there are less than 12 playing cards even when there is a set." do
    card1 = Card.new(29,1,0,0,2)
    card2 = Card.new(47,1,2,0,2)
    card3 = Card.new(35,1,0,2,2)
    card4 = Card.new(70,2,1,2,1)
    card5 = Card.new(0,0,0,0,0)
    card6 = Card.new(23,0,2,1,2)
    card7 = Card.new(38,1,1,0,2)
    card8 = Card.new(21,0,2,1,0)
    card9 = Card.new(58,2,0,1,1)

    #all cards below are cards that can be added to form a set in the 6 cards above.
    card10 = Card.new(3,0,0,1,0)
    card11 = Card.new(41,1,1,1,2)
    card12 = Card.new(16,0,1,2,1)
    $cardsShowing = [card1, card2, card3, card4, card5, card6, card7, card8, card9]
    $deck = [card10,card11,card12]
    dealCards

    expect($cardsShowing.eql?([card1, card2, card3, card4, card5, card6, card7, card8, card9,card10,card11,card12].to_a))
  end

end

context "There is a set and more than or equal to 12 cards. There are also cards unplayed left." do

  it "Does not add cards when there is a set and there are at least 12 cards." do
    card1 = Card.new(29,1,0,0,2)
    card2 = Card.new(47,1,2,0,2)
    card3 = Card.new(35,1,0,2,2)
    card4 = Card.new(70,2,1,2,1)
    card5 = Card.new(0,0,0,0,0)
    card6 = Card.new(23,0,2,1,2)
    card7 = Card.new(38,1,1,0,2)
    card8 = Card.new(21,0,2,1,0)
    card9 = Card.new(58,2,0,1,1)
    card10 = Card.new(3,0,0,1,0)
    card11 = Card.new(41,1,1,1,2)
    card12 = Card.new(16,0,1,2,1)

    card13 = Card.new(15,0,1,2,0)
    card14 = Card.new(50,1,2,1,2)
    card15 = Card.new(13,0,1,1,1)
    $cardsShowing = [card1, card2, card3, card4, card5, card6, card7, card8, card9, card10,card11,card12]
    $deck = [card13,card14,card15]
    dealCards

    expect($cardsShowing.eql?([card1, card2, card3, card4, card5, card6, card7, card8, card9, card10, card11, card12].to_a))
  end

end


# Created 09/09/2019 by David Wing
# Edited 09/08/2019 by david
# Tests for valid sets
context "Check table for valid sets" do
  it "returns empty array when there are no valid sets and only 3 cards" do
    card1 = Card.new(28,1,0,0,1)
    card2 = Card.new(47,1,2,0,2)
    card3 = Card.new(38,1,1,0,2)    
    $cardsShowing = [card1, card2, card3]
    expected = []
    expect(valid_table()).to eql(expected)
  end

  it "returns an index array of valid cards when there is only a valid set left" do 
    card1 = Card.new(80,2,2,2,2)
    card2 = Card.new(79,2,2,2,1)
    card3 = Card.new(78,2,2,2,0)
    $cardsShowing = [card1, card2, card3]

    expected = [0,1,2]
    ret = valid_table()

    expect(ret).to eql(expected)
  end

  it "returns an empty array when there are no valid sets in a standard 12 card table" do

    $cardsShowing =[
      Card.new(0,0,0,0,0),
      Card.new(30,1,0,1,0),
      Card.new(27,1,0,0,0),
      Card.new(3,0,0,1,0),
      Card.new(9,0,1,0,0),
      Card.new(39,1,1,1,0),
      Card.new(36,1,1,0,0),
      Card.new(12,0,1,1,0),
      Card.new(19,0,2,0,1),
      Card.new(76,2,2,1,1),
      Card.new(74,2,2,0,2),
      Card.new(23,0,2,1,2)
    ]

    expected = []
    expect(valid_table()).to eql(expected)
  end

  it "returns an valid card array when there is a valid sets in a standard 12 card table" do

    $cardsShowing =[
      Card.new(0,0,0,0,0),
      Card.new(30,1,0,1,0),
      Card.new(27,1,0,0,0),
      Card.new(3,0,0,1,0),
      Card.new(9,0,1,0,0),
      Card.new(39,1,1,1,0),
      Card.new(36,1,1,0,0),
      Card.new(12,0,1,1,0),
      Card.new(18,0,2,0,0),
      Card.new(76,2,2,1,1),
      Card.new(74,2,2,0,2),
      Card.new(23,0,2,1,2)
    ]

    expected = [0,4,8]
    ret = valid_table()

    expect(ret).to eql(expected)
  end

  it "returns an array of valid cards when there is a full table of cards" do 
    deck = createDeck
    $cardsShowing = deck

    #first set that is generated by createDeck
    card1 = Card.new(80,2,2,2,2)
    card2 = Card.new(79,2,2,2,1)
    card3 = Card.new(78,2,2,2,0)

    ret = valid_table()

    expected = [0,1,2]

    expect(ret).to eql(expected)
  end    

end

# Created 09/08/2019 by Leah Gillespie
context "Checks that the deck is created correctly" do

  it "Creates a deck with 81 cards" do
    deck = createDeck
    expect deck.length == 81
  end

  it "Creates cards that have a valid value (0, 1, or 2) for the number attribute" do
    deck = createDeck
    isValid = true

    deck.each do |card|
      isValid = isValid && (card.number == 0 || card.number == 1 || card.number == 2)
    end

    expect isValid
  end

  it "Creates cards that have a valid value (0, 1, or 2) for the color attribute" do
    deck = createDeck
    isValid = true

    deck.each do |card|
      isValid = isValid && (card.color == 0 || card.color == 1 || card.color == 2)
    end

    expect isValid
  end

  it "Creates cards that have a valid value (0, 1, or 2) for the shape attribute" do
    deck = createDeck
    isValid = true

    deck.each do |card|
      isValid = isValid && (card.shape == 0 || card.shape == 1 || card.shape == 2)
    end

    expect isValid
  end

  it "Creates cards that have a valid value (0, 1, or 2) for the shade attribute" do
    deck = createDeck
    isValid = true

    deck.each do |card|
      isValid = isValid && (card.shade == 0 || card.shade == 1 || card.shade == 2)
    end

    expect isValid
  end

  it "Creates 81 unique cards" do
    deck = createDeck
    isUnique = true
    for i in 0...80
      currentCard = deck.at i
      for n in i..80
        checkCard = deck.at n
        isUnique = currentCard.number != checkCard.number || currentCard.color != checkCard.color || currentCard.shape != checkCard.shape || currentCard.shade != checkCard.shade
      end
    end
    expect isUnique
  end

end


# Created 09/13 David 
context "Checks hints are correct" do

  it "returns 2 cards that could make up a set" do
    card1 = Card.new(80,2,2,2,2)
    card2 = Card.new(79,2,2,2,1)
    card3 = Card.new(78,2,2,2,0)
    
    $cardsShowing = [card1, card2, card3, Card.new(76,2,2,1,1), Card.new(74,2,2,0,2),  Card.new(23,0,2,1,2)]
    
    expected = [card1, card2]
    ret = get_hint(valid_table)

    expect(ret).to eql(expected)
    
  end

  it "returns 2 cards that could make up a set from a table " do
    card1 = Card.new(80,2,2,2,2)
    card2 = Card.new(79,2,2,2,1)
    card3 = Card.new(78,2,2,2,0)
    $cardsShowing = [card1, card2, card3]

    expected = [card1, card2]
    ret = get_hint(valid_table)

    expect(ret).to eql(expected)
    
  end
end
