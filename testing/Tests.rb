#File created 09/05/2019 by Neel Mansukhani
#
require_relative("../Set")


  # Created 09/05/2019 by Sri Ramya Dandu
  # Tests for isASet? function
  context "All 3 cards have the same attributes for all categories " do

    it "Returns true when all cards have attribute 1" do
      card1 = Card.new(1,1,1,1)
      card2 = Card.new(1,1,1,1)
      card3 = Card.new(1,1,1,1)

      expect(isASet?(card1,card2,card3)).to eq(true)
    end

    it "Returns true when all cards have attribute 2" do
      card1 = Card.new(2,2,2,2)
      card2 = Card.new(2,2,2,2)
      card3 = Card.new(2,2,2,2)

      expect(isASet?(card1,card2,card3)).to eq(true)
    end

    it "Returns true when all cards have attribute 3" do
      card1 = Card.new(3,3,3,3)
      card2 = Card.new(3,3,3,3)
      card3 = Card.new(3,3,3,3)

      expect(isASet?(card1,card2,card3)).to eq(true)
    end
  end

  it "Returns true if 3 cards have the different attributes for all categories" do
    card1 = Card.new(1,3,3,2)
    card2 = Card.new(2,2,1,3)
    card3 = Card.new(3,1,2,1)

    expect(isASet?(card1,card2,card3)).to eq(true)
  end

  context "Cards are not valid sets" do
    it "returns false when 1 attribute requirement isn't met" do
      card1 = Card.new(1,3,1,2)
      card2 = Card.new(2,3,1,3)
      card3 = Card.new(3,3,2,1)

      expect(isASet?(card1,card2,card3)).to eq(false)
    end

    it "returns false when 2 attribute requirements aren't met" do
      card1 = Card.new(1,3,1,2)
      card2 = Card.new(2,3,1,3)
      card3 = Card.new(3,3,2,2)

      expect(isASet?(card1,card2,card3)).to eq(false)
    end

    it "returns false when 3 attribute requirements aren't met" do
      card1 = Card.new(1,3,1,2)
      card2 = Card.new(2,1,1,3)
      card3 = Card.new(3,3,2,2)

      expect(isASet?(card1,card2,card3)).to eq(false)
    end

    it "returns false when all attribute requirements aren't met" do
      card1 = Card.new(1,3,1,2)
      card2 = Card.new(1,1,1,3)
      card3 = Card.new(3,3,2,2)

      expect(isASet?(card1,card2,card3)).to eq(false)
    end

    context "white box testing of the function to ensure each if statement works" do
      it "returns false when the symbol attribute requirement isn't met, but all others are met" do
        card1 = Card.new(1,1,3,2)
        card2 = Card.new(1,1,1,2)
        card3 = Card.new(3,1,2,2)

        expect(isASet?(card1,card2,card3)).to eq(false)
      end

      it "returns false when the color attribute requirement isn't met, but all others are met" do
        card1 = Card.new(1,1,3,2)
        card2 = Card.new(1,2,1,2)
        card3 = Card.new(1,1,2,2)

        expect(isASet?(card1,card2,card3)).to eq(false)
      end

      it "returns false when the shape attribute requirement isn't met, but all others are met" do
        card1 = Card.new(1,3,3,2)
        card2 = Card.new(1,2,3,2)
        card3 = Card.new(1,1,2,2)

        expect(isASet?(card1,card2,card3)).to eq(false)
      end

      it "returns false when the shape attribute requirement isn't met, but all others are met" do
        card1 = Card.new(1,3,3,1)
        card2 = Card.new(1,2,3,2)
        card3 = Card.new(1,1,3,2)

        expect(isASet?(card1,card2,card3)).to eq(false)
      end
    end
  end
end