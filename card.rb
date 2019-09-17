# File Created 9/15/019 David Wing
# Defines methods and structures for Card object

require_relative 'Set'
require_relative 'deck'

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

    def image
      blank_card = Gosu::Image.new("media/card.png", :tileable => true)
      if @color == 0
        color = Gosu::Color::RED
      elsif @color == 1
        color = Gosu::Color::BLUE
      else
        color = Gosu::Color::GREEN
      end
      img = Gosu.render(587,940) {
        blank_card.draw(0,0,ZOrder::CARDS, 1.0, 1.0)
        x, y = 50, 100
        for shapes in 0..@number
          if @shape == 0
            Gosu.draw_rect(x,y,487,200,color,ZOrder::CARDS)
            Gosu.draw_rect(x+20,y+20,487 - 40,200 - 40,Gosu::Color::WHITE,ZOrder::CARDS) if @shade != 0
          elsif @shape == 1
            Gosu.draw_triangle(294, y, color, 94, y + 200, color, 494, y + 200, color,ZOrder::CARDS)
            Gosu.draw_triangle(294, y + 20, Gosu::Color::WHITE, 94 + 40, y + 200 - 20, Gosu::Color::WHITE, 494 - 40, y + 200 - 20, Gosu::Color::WHITE,ZOrder::CARDS) if @shade != 0
          else
            Gosu.draw_quad(x,y,color,x+437,y,color,x+50,y+200,color,x+487,y+200,color,ZOrder::CARDS)
            Gosu.draw_quad(x+20,y+20,Gosu::Color::WHITE,x+437-20,y+20,Gosu::Color::WHITE,x+50+20,y+200-20,Gosu::Color::WHITE,x+487-20,y+200-20,Gosu::Color::WHITE,ZOrder::CARDS) if @shade != 0
          end
          y += 250
        end
      }
    end
  end