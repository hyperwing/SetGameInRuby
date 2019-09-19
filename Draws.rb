# File Created 09/17/2019 by Neel Mansukhani
# This file contains all of the

# Edited by Neel Mansukhani 09/18/2019 by Neel Mansukhani: Created Draws Module
module Draws
  # Created 09/15/2019 by Sri Ramya Dandu
  # Edited 09/15/2019 by Neel Mansukhani: Moved to Draw File
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
    draw_rect(190,220,20,20,Gosu::Color::GRAY,ZOrder::UI) if @settings_hovered == Options::START_SCREEN[0]
    draw_rect(360,220,20,20,Gosu::Color::GRAY,ZOrder::UI) if @settings_hovered == Options::START_SCREEN[1]
    draw_rect(530,220,20,20,Gosu::Color::GRAY,ZOrder::UI) if @settings_hovered == Options::START_SCREEN[2]
  end

  # Created 09/15/2019 by Sri Ramya Dandu
  # Edited 09/15/2019 by Neel Mansukhani: Moved to Draw File
  # Draws images, shapes, and text on level select screen.
  def levelsScreen
    @title_font.draw_text("Choose a level of difficulty", 170, 50, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
    @buttonOption.draw(360,90, ZOrder::BUTTON,0.15,0.15)
    @buttonOption.draw(360,170, ZOrder::BUTTON,0.15,0.15)
    @buttonOption.draw(360,250, ZOrder::BUTTON,0.15,0.15)
    @subtitle_font.draw_text(Options::LEVELS_SCREEN[0], 410, 151, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
    @subtitle_font.draw_text(Options::LEVELS_SCREEN[1], 400, 230, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
    @subtitle_font.draw_text(Options::LEVELS_SCREEN[2], 410, 310, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
    draw_rect(360,90,20,20,Gosu::Color::GRAY,ZOrder::UI) if @settings_hovered == Options::LEVELS_SCREEN[0]
    draw_rect(360,170,20,20,Gosu::Color::GRAY,ZOrder::UI) if @settings_hovered == Options::LEVELS_SCREEN[1]
    draw_rect(360,250,20,20,Gosu::Color::GRAY,ZOrder::UI) if @settings_hovered == Options::LEVELS_SCREEN[2]
  end
end
