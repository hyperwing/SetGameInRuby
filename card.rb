# File Created 9/15/019 David Wing
# Defines methods and structures for Card object


# TODO: Add file description for every file.
# TODO: Multi line comments for function descriptions.
# Created 09/05/2019 by Leah Gillespie
# Edited 09/06/2019 by Neel Mansukhani: Added id and set_id function to Card
# Edited 09/10/2019 by David Wing: Added id to initialize.
# Edited 09/14/2019 by Neel Mansukhani: Added attribute accessor.
class Card

    attr_accessor :id, :number, :color, :shape, :shade
  
    # Created 09/05/2019 by Leah Gillespie
    # Edited 09/10/2019 by David Wing: Added id
    # Edited 09/15/2019 by Sri Ramya Dandu: Added documentation
  
    # Creates a new instance of Card with the given attributes
    def initialize(id, number, color, shape, shade)
      @id = id
      @number = number
      @color = color
      @shape = shape
      @shade = shade
    end
  
    # Created 09/05/2019 by Neel Mansukhani
    # Edited 09/06/2019 by Neel Mansukhani: Cleaned up display
    # Edited 09/15/2019 by Sri Ramya Dandu: Added documentation
  
    # Prints out the cards attributes
    def display
      print("Card: #{@id} ")
      print("Number: #{@number} ")
      print("Color: #{@color} ")
      print("Shape: #{@shape} ")
      puts("Shade: #{@shade}")
    end
  end