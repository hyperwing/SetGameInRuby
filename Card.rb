# File Created 09/15/2019 by Neel Mansukhani
require 'gosu'
# Created 09/05/2019 by Leah Gillespie
# Edited 09/06/2019 by Neel Mansukhani: Added id and set_id function to Card
# Edited 09/10/2019 by David Wing: Added id to initialize.
# Edited 09/14/2019 by Neel Mansukhani: Added attribute accessor.
# Edited 09/15/2019 by Neel Mansukhani: Moved class to separate file.
class Card

  attr_accessor :id, :number, :color, :shape, :shade

  # Created 09/05/2019 by Leah Gillespie
  # Edited 09/10/2019 by David Wing
  def initialize(id, number, color, shape, shade)
    @id = id
    @number = number
    @color = color
    @shape = shape
    @shade = shade
  end

  # Created 09/05/2019 by Neel Mansukhani
  # Edited 09/06/2019 by Neel Mansukhani: Cleaned up display
  def display
    print("Card: #{@id} ")
    print("Number: #{@number} ")
    print("Color: #{@color} ")
    print("Shape: #{@shape} ")
    puts("Shade: #{@shade}")
  end
  def createCard
    # TODO: Make this.
  end
end