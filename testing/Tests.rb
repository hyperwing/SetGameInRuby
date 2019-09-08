#File created 09/05/2019 by Neel Mansukhani
#Edited 09/05/2019 by Sri Ramya Dandu
# Edited 09/07/2019 by Sri Ramya Dandu
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
    expect(valid_table?(tableArray)).to eql(expected)
  end

  it "returns an array of valid cards when there is only a valid set left" do 
    card1 = Card.new(0,0,0,0)
    card2 = Card.new(0,0,0,0)
    card3 = Card.new(0,0,0,0)
    tableArray = [card1, card2, card3]

    expected = [card1, card2, card3]
    ret = valid_table?(tableArray)

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
    expect(valid_table?(tableArray)).to eql(expected)
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

    ret = valid_table?(tableArray)

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

    ret = valid_table?(tableArray)

    expect(ret[0]).to have_attributes(:shape => 2, :number=>2, :shade=>2, :color=>2)
    expect(ret[1]).to have_attributes(:shape => 2, :number=>2, :shade=>1, :color=>2)
    expect(ret[2]).to have_attributes(:shape => 2, :number=>2, :shade=>0, :color=>2)
  end    


end
