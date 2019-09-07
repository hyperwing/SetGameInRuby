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

=begin
  #9/06 David Wing
  #Tests for valid sets
  context "Check table for valid set" do
    it "returns false when there are no valid sets" do
      row1 = []
      row2 = []
      row3 = []

      expect(valid_table?(row1, row2, row3)).to eq(false)
    end
  end
=end