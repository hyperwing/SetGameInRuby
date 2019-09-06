#File created 09/05/2019 by Neel Mansukhani

require_relative("../Set")

describe Card do
  it "returns 0" do
    x = Card.new(1,1,1,1)

    expect(x.symbol).to eq(1)
  end
end