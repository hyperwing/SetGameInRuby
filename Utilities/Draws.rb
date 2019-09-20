# File Created 09/17/2019 by Neel Mansukhani
# This file contains all of the

# Edited by Neel Mansukhani 09/18/2019 by Neel Mansukhani: Created Draws Module
# Edited 09/20/2019 by Leah Gillespie
module Draws
  # Created 09/15/2019 by Sri Ramya Dandu
  # Edited 09/15/2019 by Neel Mansukhani: Moved to Draw File
  # Edited 09/19/2019 by Sharon Qiu: Edited offset of drawn rectangles.
  # Edited 09/20/2019 by Leah Gillespie: Adjusted text, button, and highlight positions for new window size

  # Draws images, shapes, and text on start screen.
  def startScreen
    @title_font.draw_text("The Game of Set", 300, 50, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
    @subtitle_font.draw_text("Instructions: Select a mode of play below. The objective of the game is to identify as many", 100, 115, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
    @subtitle_font.draw_text("sets as possible. 3 cards form a set when they all have the same or all different numbers,", 100, 145, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
    @subtitle_font.draw_text("shapes, shadings, and colors. Player 1 will use the w, a, s, and d keys to move and the space", 100, 175, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
    @subtitle_font.draw_text("bar to select. If there is a second player, they will used the arrow keys to move and the", 100, 205, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
    @subtitle_font.draw_text("enter key to select. A colored box will appear on the card you are currently on, and will", 100, 235, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
    @subtitle_font.draw_text("remain there when you have selected it. Player 1 is blue and player 2 is pink. Good luck!", 100, 265, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
    @buttonOption.draw(210,310, ZOrder::BUTTON,0.15,0.15)
    @buttonOption.draw(380,310, ZOrder::BUTTON,0.15,0.15)
    @buttonOption.draw(550,310, ZOrder::BUTTON,0.15,0.15)
    @subtitle_font.draw_text(Options::START_SCREEN[0], 260, 372, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
    @subtitle_font.draw_text(Options::START_SCREEN[1], 415, 372, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
    @subtitle_font.draw_text(Options::START_SCREEN[2], 593, 372, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)

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
    left_x ,right_x, top_y, bottom_y, button_distance = 220, 325, 350, 400, 170

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
    @title_font.draw_text("Choose a level of difficulty", 180, 50, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
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

  # Created 9/18/2019 by David Wing
  # Edited 9/19/2019 by David Wing added different images for modes
  # Edited 9/20/2019 by David Wing added rectangle select
  def gameOverScreen
    @subtitle_font.draw_text("Final Score for player 1: #{@p1.score}", 170, 130, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    
    if @game_settings.p2Init # 2Player mode
      @subtitle_font.draw_text("Final Score for player 2: #{@p2.score}", 170, 150, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
      @background_image = Gosu::Image.new("media/gob.png", :tileable => true)

      if @p1.score> @p2.score #P1 win
        @image = (Gosu::Image.new("media/p1win.png"))
      elsif @p2.score > @p1.score #P2 win
        @image = (Gosu::Image.new("media/p2win.png"))
      else #TIE
        @image = (Gosu::Image.new("media/tie.png"))
      end

    elsif @game_settings.isCPUPlayerEnabled #CPU mode
      @subtitle_font.draw_text("Final Score for CPU: #{@computer_signal.score}", 170, 150, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
      if @computer_signal.score < @p1.score
        @background_image = Gosu::Image.new("media/youwin.png", :tileable => true)
        @image = (Gosu::Image.new("media/youwinText.png"))
      else
        @image = (Gosu::Image.new("media/Gameover.png"))
        @background_image = Gosu::Image.new("media/gob.png", :tileable => true)

      end
    else #Single Player mode
      @image = (Gosu::Image.new("media/Gameover.png"))
      @background_image = Gosu::Image.new("media/gob.png", :tileable => true)
    end

    @buttonOption.draw(190,220, ZOrder::BUTTON,0.15,0.15)
    @buttonOption.draw(360,220, ZOrder::BUTTON,0.15,0.15)
    @subtitle_font.draw_text(Options::GAMEOVER_SCREEN[0], 240, 282, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
    @subtitle_font.draw_text(Options::GAMEOVER_SCREEN[1], 395, 282, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)

    # draw player movement
    left_x ,right_x, top_y, bottom_y, button_distance = 200, 300, 250, 300, 170

    # reflects each corner  
    if @settings_hovered == Options::GAMEOVER_SCREEN[0]
      draw_rect(left_x + (button_distance * 0),top_y,20,20,Gosu::Color::GRAY,ZOrder::TEXT)
      draw_rect(right_x + (button_distance * 0),top_y,20,20,Gosu::Color::GRAY,ZOrder::TEXT)
      draw_rect(left_x + (button_distance * 0),bottom_y,20,20,Gosu::Color::GRAY,ZOrder::TEXT)
      draw_rect(right_x + (button_distance * 0),bottom_y,20,20,Gosu::Color::GRAY,ZOrder::TEXT)
    else
      draw_rect(left_x + (button_distance * 1),top_y,20,20,Gosu::Color::GRAY,ZOrder::TEXT)
      draw_rect(right_x + (button_distance * 1),top_y,20,20,Gosu::Color::GRAY,ZOrder::TEXT)
      draw_rect(left_x + (button_distance * 1),bottom_y,20,20,Gosu::Color::GRAY,ZOrder::TEXT)
      draw_rect(right_x + (button_distance * 1),bottom_y,20,20,Gosu::Color::GRAY,ZOrder::TEXT)
    end

    # draw_rect(230,250,20,20,Gosu::Color::GRAY,ZOrder::UI) if @settings_hovered == Options::GAMEOVER_SCREEN[0]
    # draw_rect(385,250,20,20,Gosu::Color::GRAY,ZOrder::UI) if @settings_hovered == Options::GAMEOVER_SCREEN[1]
    # @image = (Gosu::Image.new("media/Gameover.png"))
    @image.draw(190,30,20)

    
  end
end
