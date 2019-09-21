# File Created 09/15/2019 by David Wing
# Edited 09/17/2019 by Neel Mansukhani
# Edited 09/18/2019 by Neel Mansukhani
# Edited 09/20/2019 by Neel Mansukhani
# Defines methods and structures for Card object

# Created 09/05/2019 by Leah Gillespie
# Edited 09/06/2019 by Neel Mansukhani: Added id and set_id function to Card
# Edited 09/10/2019 by David Wing: Added id to initialize.
# Edited 09/14/2019 by Neel Mansukhani: Added attribute accessor.
class Card

    attr_accessor :id, :number, :color, :shape, :shade, :image
  
    # Created 09/05/2019 by Leah Gillespie
    # Edited 09/10/2019 by David Wing: Added id
    # Edited 09/15/2019 by Sri Ramya Dandu: Added documentation
    # Edited 09/17/2019 by Neel Mansukhani: Card is rendered on initialization.
    # Creates a new instance of Card with the given attributes
    def initialize(id, number, color, shape, shade)
      @id = id
      @number = number
      @color = color
      @shape = shape
      @shade = shade
      @image = create_card
    end

    # Created 09/16/2019 by Neel Mansukhani
    # Edited 09/17/2019 by Neel Mansukhani: Accounted for shade
    # Edited 09/18/2019 by Neel Mansukhani: Fixed parallelogram shade.
    # Edited 09/20/2019 by Neel Mansukhani: Changed for loop to times.
    # Renders card based on its number, color, shape, shade
    def create_card
      blank_card = Gosu::Image.new("media/card.png", :tileable => true)
      case @color
      when 0
        color = Gosu::Color::RED
      when 1
        color = Gosu::Color::BLUE
      when 2
        color = Gosu::Color::GREEN
      end
      img = Gosu.render 587, 940 do
        blank_card.draw 0, 0, ZOrder::CARDS, 1.0, 1.0
        x_pos, y_pos = 50, 100
        (@number + 1).times do
          case @shape
          when 0
            Gosu.draw_rect x_pos, y_pos, 487, 200, color, ZOrder::CARDS
            Gosu.draw_rect x_pos + 20, y_pos + 20, 447, 160, Gosu::Color::WHITE, ZOrder::CARDS if @shade != 0
            if @shade == 2
              Gosu.draw_rect x_pos, y_pos + 40, 487, 20, color, ZOrder::CARDS
              Gosu.draw_rect x_pos, y_pos + 90, 487, 20, color, ZOrder::CARDS
              Gosu.draw_rect x_pos, y_pos + 130, 487, 20, color, ZOrder::CARDS
            end
          when 1
            Gosu.draw_triangle 294, y_pos, color, 94, y_pos + 200, color, 494, y_pos + 200, color,ZOrder::CARDS
            Gosu.draw_triangle 294, y_pos + 20, Gosu::Color::WHITE, 94 + 40, y_pos + 200 - 20, Gosu::Color::WHITE, 494 - 40, y_pos + 200 - 20, Gosu::Color::WHITE,ZOrder::CARDS  if @shade != 0
            if @shade == 2
              Gosu.draw_rect 254, y_pos + 40, 80, 20, color, ZOrder::CARDS
              Gosu.draw_rect 204, y_pos + 90, 180, 20, color, ZOrder::CARDS
              Gosu.draw_rect 164, y_pos + 130, 260, 20, color, ZOrder::CARDS
            end
          when 2
            Gosu.draw_quad x_pos, y_pos, color, x_pos + 437, y_pos, color, x_pos + 50, y_pos+200, color, x_pos + 487, y_pos + 200, color, ZOrder::CARDS
            Gosu.draw_quad x_pos + 20, y_pos + 20, Gosu::Color::WHITE, x_pos + 417, y_pos + 20, Gosu::Color::WHITE, x_pos + 70, y_pos + 180, Gosu::Color::WHITE, x_pos + 457, y_pos + 180, Gosu::Color::WHITE, ZOrder::CARDS  if @shade != 0
            if @shade == 2
              Gosu.draw_rect x_pos + 15, y_pos + 40, 437, 20, color, ZOrder::CARDS
              Gosu.draw_rect x_pos + 30, y_pos + 90, 427, 20, color, ZOrder::CARDS
              Gosu.draw_rect x_pos + 45, y_pos + 130, 427, 20, color, ZOrder::CARDS
            end
          end
          y_pos += 250
        end
      end
    end
  end
