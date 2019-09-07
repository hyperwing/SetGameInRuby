#File created 09/05/2019 by Neel Mansukhani
#
require_relative("../Set")

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
