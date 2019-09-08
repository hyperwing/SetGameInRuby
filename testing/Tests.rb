#File created 09/05/2019 by Neel Mansukhani
#Edited 09/05/2019 by Sri Ramya Dandu
# Edited 09/07/2019 by Sri Ramya Dandu
# Edited 09/08/2019 by Sharon Qiu

require_relative("../Set")

# Created 09/05/2019 by Sri Ramya Dandu
# Tests for isASet? function
# Edited 09/07/2019 by Sri Ramya Dandu: changed the input to reflect input changes in method
#

context "All 3 cards have the same attributes for all categories " do

  it "Returns true when all cards have attribute 1" do
    card1 = Card.new(1,1,1,1)
    card2 = Card.new(1,1,1,1)
    card3 = Card.new(1,1,1,1)
    set = [card1, card2, card3]


    expect(isASet?(set)).to eq(true)
  end

  it "Returns true when all cards have attribute 2" do
    card1 = Card.new(2,2,2,2)
    card2 = Card.new(2,2,2,2)
    card3 = Card.new(2,2,2,2)
    set = [card1, card2, card3]

    expect(isASet?(set)).to eq(true)
  end

  it "Returns true when all cards have attribute 3" do
    card1 = Card.new(0,0,0,0)
    card2 = Card.new(0,0,0,0)
    card3 = Card.new(0,0,0,0)
    set = [card1, card2, card3]

    expect(isASet?(set)).to eq(true)
  end
end

context "All cards have different attributes" do
  it "Returns true if 3 cards have the different attributes for all categories" do
    card1 = Card.new(1,0,0,2)
    card2 = Card.new(2,2,1,0)
    card3 = Card.new(0,1,2,1)
    set = [card1, card2, card3]

    expect(isASet?(set)).to eq(true)
  end
end

context "Cards are not valid sets" do
  it "returns false when 1 attribute requirement isn't met" do
    card1 = Card.new(1,0,1,2)
    card2 = Card.new(2,0,1,0)
    card3 = Card.new(0,0,2,1)
    set = [card1, card2, card3]

    expect(isASet?(set)).to eq(false)
  end

  it "returns false when 2 attribute requirements aren't met" do
    card1 = Card.new(1,0,1,2)
    card2 = Card.new(2,0,1,0)
    card3 = Card.new(0,0,2,2)
    set = [card1, card2, card3]

    expect(isASet?(set)).to eq(false)
  end

  it "returns false when 3 attribute requirements aren't met" do
    card1 = Card.new(1,0,1,2)
    card2 = Card.new(2,1,1,0)
    card3 = Card.new(0,0,2,2)
    set = [card1, card2, card3]

    expect(isASet?(set)).to eq(false)
  end

  it "returns false when all attribute requirements aren't met" do
    card1 = Card.new(1,0,1,2)
    card2 = Card.new(1,1,1,0)
    card3 = Card.new(0,0,2,2)
    set = [card1, card2, card3]

    expect(isASet?(set)).to eq(false)
  end
end

context "white box testing of the function to ensure each if statement works" do
  it "returns false when the symbol attribute requirement isn't met, but all others are met" do
    card1 = Card.new(1,1,0,2)
    card2 = Card.new(1,1,1,2)
    card3 = Card.new(0,1,2,2)
    set = [card1, card2, card3]

    expect(isASet?(set)).to eq(false)
  end

  it "returns false when the color attribute requirement isn't met, but all others are met" do
    card1 = Card.new(1,1,0,2)
    card2 = Card.new(1,2,1,2)
    card3 = Card.new(1,1,2,2)
    set = [card1, card2, card3]

    expect(isASet?(set)).to eq(false)
  end

  it "returns false when the shape attribute requirement isn't met, but all others are met" do
    card1 = Card.new(1,0,0,2)
    card2 = Card.new(1,2,0,2)
    card3 = Card.new(1,1,2,2)
    set = [card1, card2, card3]

    expect(isASet?(set)).to eq(false)
  end

  it "returns false when the shape attribute requirement isn't met, but all others are met" do
    card1 = Card.new(1,0,0,1)
    card2 = Card.new(1,2,0,2)
    card3 = Card.new(1,1,0,2)
    set = [card1, card2, card3]

    expect(isASet?(set)).to eq(false)
  end
end

# Created 09/08/2019 by Sharon Qiu
# Tests for dealCards method
context "No more unplayed cards in the deck left." do

  it "Does not add cards when cards showing is empty and deck of unplayed cards is empty." do
    playingSet = []
    unplayedDeck = []
    dealCards(unplayedDeck,playingSet)

    expect(playingSet.eql?([].to_a))
  end

  it "Does not add cards when there is a set and no more unplayed cards left." do
    card1 = Card.new(1,0,1,2)
    card2 = Card.new(1,2,0,2)
    card3 = Card.new(1,1,2,2)
    playingSet = [card1, card2, card3]
    unplayedDeck = []
    dealCards(unplayedDeck,playingSet)

    expect(playingSet.eql?([card1, card2, card3].to_a))
  end

  it "Does not add cards when there is not a set and no more unplayed cards left." do
    card1 = Card.new(1,0,0,2)
    card2 = Card.new(1,2,0,2)
    card3 = Card.new(1,1,2,2)
    playingSet = [card1, card2, card3]
    unplayedDeck = []
    dealCards(unplayedDeck,playingSet)

    expect(playingSet.eql?([card1, card2, card3].to_a))
  end
end

context "There is not a set in the current cards and there are cards unplayed left." do

  it "Adds cards when there are less than 12 playing cards and until there is a set in the set." do
    card1 = Card.new(1,0,0,2)
    card2 = Card.new(1,2,0,2)
    card3 = Card.new(1,0,2,2)
    card4 = Card.new(2,1,2,1)
    card5 = Card.new(0,0,0,0)
    card6 = Card.new(0,2,1,2)

    #all cards below are cards that can be added to form a set in the 6 cards above.
    card7 = Card.new(1,1,0,2)
    card8 = Card.new(0,2,1,0)
    card9 = Card.new(2,0,1,1)
    card10 = Card.new(0,0,1,0)
    card11 = Card.new(1,1,1,2)
    card12 = Card.new(0,1,2,1)
    playingSet = [card1, card2, card3, card4, card5, card6]
    unplayedDeck = [card7, card8, card9,card10,card11,card12]
    dealCards(unplayedDeck,playingSet)

    expect(playingSet.length == 9)
  end

  it "Adds cards when there is no set but more than 12 cards played." do

    card1 = Card.new(0,0,0,0)
    card2 = Card.new(1,0,1,0)
    card3 = Card.new(1,0,0,0)
    card4 = Card.new(0,0,1,0)
    card5 = Card.new(0,1,0,0)
    card6 = Card.new(1,1,1,0)
    card7 = Card.new(1,1,0,0)
    card8 = Card.new(0,1,1,0)
    card9 = Card.new(0,2,0,1)
    card10 = Card.new(2,2,1,1)
    card11 = Card.new(2,2,0,2)
    card12 = Card.new(0,2,1,2)

    card13 = Card.new(2,0,2,0)
    card14 = Card.new(0,2,2,0)
    card15 = Card.new(2,2,2,0)
    playingSet = [card1, card2, card3, card4, card5, card6, card7, card8, card9, card10,card11,card12]
    unplayedDeck = [card13,card14,card15]
    dealCards(unplayedDeck,playingSet)

    expect(playingSet.eql?([card1, card2, card3, card4, card5, card6, card7, card8, card9, card10, card11, card12,card13,card14,card15].to_a))
  end

end

context "There is a set, but less than 12 cards. There are also cards unplayed left." do

  it "Adds cards when there are less than 12 playing cards even when there is a set." do
    card1 = Card.new(1,0,0,2)
    card2 = Card.new(1,2,0,2)
    card3 = Card.new(1,0,2,2)
    card4 = Card.new(2,1,2,1)
    card5 = Card.new(0,0,0,0)
    card6 = Card.new(0,2,1,2)
    card7 = Card.new(1,1,0,2)
    card8 = Card.new(0,2,1,0)
    card9 = Card.new(2,0,1,1)

    #all cards below are cards that can be added to form a set in the 6 cards above.
    card10 = Card.new(0,0,1,0)
    card11 = Card.new(1,1,1,2)
    card12 = Card.new(0,1,2,1)
    playingSet = [card1, card2, card3, card4, card5, card6, card7, card8, card9]
    unplayedDeck = [card10,card11,card12]
    dealCards(unplayedDeck,playingSet)

    expect(playingSet.eql?([card1, card2, card3, card4, card5, card6, card7, card8, card9,card10,card11,card12].to_a))
  end

end

context "There is a set and more than or equal to 12 cards. There are also cards unplayed left." do

  it "Does not add cards when there is a set and there are at least 12 cards." do
    card1 = Card.new(1,0,0,2)
    card2 = Card.new(1,2,0,2)
    card3 = Card.new(1,0,2,2)
    card4 = Card.new(2,1,2,1)
    card5 = Card.new(0,0,0,0)
    card6 = Card.new(0,2,1,2)
    card7 = Card.new(1,1,0,2)
    card8 = Card.new(0,2,1,0)
    card9 = Card.new(2,0,1,1)
    card10 = Card.new(0,0,1,0)
    card11 = Card.new(1,1,1,2)
    card12 = Card.new(0,1,2,1)

    card13 = Card.new(0,1,2,0)
    card14 = Card.new(1,2,1,2)
    card15 = Card.new(0,1,1,1)
    playingSet = [card1, card2, card3, card4, card5, card6, card7, card8, card9, card10,card11,card12]
    unplayedDeck = [card13,card14,card15]
    dealCards(unplayedDeck,playingSet)

    expect(playingSet.eql?([card1, card2, card3, card4, card5, card6, card7, card8, card9, card10, card11, card12].to_a))
  end

end


#9/06 created by David Wing
#9/08 updated by david
#Tests for valid sets
context "Check table for valid sets" do
  it "returns empty array when there are no valid sets and only 3 cards" do
    card1 = Card.new(1,0,0,1)
    card2 = Card.new(1,2,0,2)
    card3 = Card.new(1,1,0,2)    
    tableArray = [card1, card2, card3]    
    expected = []
    expect(valid_table(tableArray)).to eql(expected)
  end

  it "returns an array of valid cards when there is only a valid set left" do 
    card1 = Card.new(0,0,0,0)
    card2 = Card.new(0,0,0,0)
    card3 = Card.new(0,0,0,0)
    tableArray = [card1, card2, card3]

    expected = [card1, card2, card3]
    ret = valid_table(tableArray)

    expect(ret[0]).to have_attributes(:shape => 0, :number=>0, :shade=>0, :color=>0)
    expect(ret[1]).to have_attributes(:shape => 0, :number=>0, :shade=>0, :color=>0)
    expect(ret[2]).to have_attributes(:shape => 0, :number=>0, :shade=>0, :color=>0)
  end

  it "returns an empty array when there are no valid sets in a standard 12 card table" do 
  
    tableArray =[
      Card.new(0,0,0,0),
      Card.new(1,0,1,0),
      Card.new(1,0,0,0),
      Card.new(0,0,1,0),
      Card.new(0,1,0,0),
      Card.new(1,1,1,0),
      Card.new(1,1,0,0),
      Card.new(0,1,1,0),
      Card.new(0,2,0,1),
      Card.new(2,2,1,1),
      Card.new(2,2,0,2),
      Card.new(0,2,1,2)
    ]

    expected = []
    expect(valid_table(tableArray)).to eql(expected)
  end

  it "returns an valid card array when there is a valid sets in a standard 12 card table" do 
  
    tableArray =[
      Card.new(0,0,0,0),
      Card.new(1,0,1,0),
      Card.new(1,0,0,0),
      Card.new(0,0,1,0),
      Card.new(0,1,0,0),
      Card.new(1,1,1,0),
      Card.new(1,1,0,0),
      Card.new(0,1,1,0),
      Card.new(0,2,0,0),
      Card.new(2,2,1,1),
      Card.new(2,2,0,2),
      Card.new(0,2,1,2)
    ]

    ret = valid_table(tableArray)

    expect(ret[0]).to have_attributes(:shape => 0, :number=>0, :shade=>0, :color=>2)
    expect(ret[1]).to have_attributes(:shape => 0, :number=>0, :shade=>0, :color=>1)
    expect(ret[2]).to have_attributes(:shape => 0, :number=>0, :shade=>0, :color=>0)
  end

  it "returns an array of valid cards when there is a full table of cards" do 
    deck = createDeck
    tableArray = deck

    #first set that is generated by createDeck
    card1 = Card.new(2,2,2,2)
    card2 = Card.new(2,2,2,1)
    card3 = Card.new(2,2,2,4)

    ret = valid_table(tableArray)

    expect(ret[0]).to have_attributes(:shape => 2, :number=>2, :shade=>2, :color=>2)
    expect(ret[1]).to have_attributes(:shape => 2, :number=>2, :shade=>1, :color=>2)
    expect(ret[2]).to have_attributes(:shape => 2, :number=>2, :shade=>0, :color=>2)
  end    

end

