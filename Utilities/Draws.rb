# File Created 09/17/2019 by Neel Mansukhani
# This file contains all of the

# Edited by Neel Mansukhani 09/18/2019 by Neel Mansukhani: Created Draws Module
module Draws
  # Created 09/15/2019 by Sri Ramya Dandu
  # Edited 09/15/2019 by Neel Mansukhani: Moved to Draw File
  # Edited 09/19/2019 by Sharon Qiu: Edited offset of drawn rectangles.
  # Draws images, shapes, and text on start screen.
  def startScreen
    @title_font.draw_text("The Game of Set", 250, 50, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
    @subtitle_font.draw_text("Instructions: Select a mode of play below. The objective of the game", 160, 115, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
    @subtitle_font.draw_text("is to identify as many sets as possible. 3 cards form a set when they", 160, 145, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
    @subtitle_font.draw_text("all have the same or all different numbers, shapes, shadings, and colors.", 160, 175, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
    @buttonOption.draw(190,220, ZOrder::BUTTON,0.15,0.15)
    @buttonOption.draw(360,220, ZOrder::BUTTON,0.15,0.15)
    @buttonOption.draw(530,220, ZOrder::BUTTON,0.15,0.15)
    @subtitle_font.draw_text(Options::START_SCREEN[0], 240, 282, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
    @subtitle_font.draw_text(Options::START_SCREEN[1], 395, 282, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
    @subtitle_font.draw_text(Options::START_SCREEN[2], 573, 282, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)

    #to get the index of the button hovered over
    hover_index = 0
    Options::START_SCREEN.each_index do |option|
      unless @settings_hovered == Options::START_SCREEN[option]
        hover_index += 1
      else
        break
      end
    end

    # draw player movement
    left_x ,right_x, top_y, bottom_y, button_distance = 200, 305, 255, 305, 170

    # reflects each corner
    draw_rect(left_x + (button_distance * hover_index),top_y,20,20,Gosu::Color::GRAY,ZOrder::TEXT)
    draw_rect(right_x + (button_distance * hover_index),top_y,20,20,Gosu::Color::GRAY,ZOrder::TEXT)
    draw_rect(left_x + (button_distance * hover_index),bottom_y,20,20,Gosu::Color::GRAY,ZOrder::TEXT)
    draw_rect(right_x + (button_distance * hover_index),bottom_y,20,20,Gosu::Color::GRAY,ZOrder::TEXT)
  end

  # Created 09/15/2019 by Sri Ramya Dandu
  # Edited 09/15/2019 by Neel Mansukhani: Moved to Draw File
  # Edited 09/19/2019 by Sharon Qiu: Edited offset of drawn rectangles.
  # Draws images, shapes, and text on level select screen.
  def levelsScreen
    @title_font.draw_text("Choose a level of difficulty", 170, 50, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
    @buttonOption.draw(360,90, ZOrder::BUTTON,0.15,0.15)
    @buttonOption.draw(360,170, ZOrder::BUTTON,0.15,0.15)
    @buttonOption.draw(360,250, ZOrder::BUTTON,0.15,0.15)
    @subtitle_font.draw_text(Options::LEVELS_SCREEN[0], 410, 151, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
    @subtitle_font.draw_text(Options::LEVELS_SCREEN[1], 400, 230, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
    @subtitle_font.draw_text(Options::LEVELS_SCREEN[2], 410, 310, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)

    #to get the index of the button hovered over
    hover_index = 0
    Options::START_SCREEN.each_index do |option|
      unless @settings_hovered == Options::LEVELS_SCREEN[option]
        hover_index += 1
      else
        break
      end
    end

    # draw player movement
    left_x ,right_x, top_y, bottom_y, button_distance = 370, 475, 125, 175, 80

    # reflects each corner
    draw_rect(left_x,top_y + (button_distance * hover_index),20,20,Gosu::Color::GRAY,ZOrder::TEXT)
    draw_rect(right_x,top_y + (button_distance * hover_index),20,20,Gosu::Color::GRAY,ZOrder::TEXT)
    draw_rect(left_x, bottom_y + (button_distance * hover_index),20,20,Gosu::Color::GRAY,ZOrder::TEXT)
    draw_rect(right_x,bottom_y + (button_distance * hover_index),20,20,Gosu::Color::GRAY,ZOrder::TEXT)

  end

  def gameOverScreen
    @subtitle_font.draw_text("Final Score for player 1: #{@p1.score}", 170, 130, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    @buttonOption.draw(190,220, ZOrder::BUTTON,0.15,0.15)
    @buttonOption.draw(360,220, ZOrder::BUTTON,0.15,0.15)
    @subtitle_font.draw_text(Options::GAMEOVER_SCREEN[0], 240, 282, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
    @subtitle_font.draw_text(Options::GAMEOVER_SCREEN[1], 395, 282, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
    draw_rect(190,220,20,20,Gosu::Color::GRAY,ZOrder::UI) if @settings_hovered == Options::GAMEOVER_SCREEN[0]
    draw_rect(360,220,20,20,Gosu::Color::GRAY,ZOrder::UI) if @settings_hovered == Options::GAMEOVER_SCREEN[1]
    @image = (Gosu::Image.new("media/Gameover.png"))
    @image.draw(190,50,20)
    @background_image = Gosu::Image.new("media/gob.png", :tileable => true)

    
  end
end
