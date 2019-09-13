# File Created 09/10/2019 by Neel Mansukhani
require 'gosu'
require_relative 'GameSettings'
module ZOrder
  BACKGROUND, UI, BUTTON, TEXT, CARDS= *0..4
end

GAME_TITLE = "The Game of Set"

class StartScreen < Gosu::Window


  def initialize
    @game_settings = GameSettings.new
    super 840, 480
    self.caption = GAME_TITLE
    @title_font = Gosu::Font.new(50)
    @subtitle_font = Gosu::Font.new(20)
    @background_image = Gosu::Image.new("media/background.jpg", :tileable => true)
    @blank_card = Gosu::Image.new("media/card.png", :tileable => true)

  end

  def update
    if Gosu.button_down? Gosu::KB_SPACE
      @game_settings.currentScreen = "game"
    end
  end

  def draw
    @background_image.draw(0, 0, ZOrder::BACKGROUND)
    if @game_settings.currentScreen == "start"
      @title_font.draw_text("The Game of Set", 140, 50, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
      @subtitle_font.draw_text("Use W, A, S, D, and Spacebar to move/select.", 130, 110, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
      @subtitle_font.draw_text("Play", 270, 200, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    elsif  @game_settings.currentScreen == "game"
      draw_rect(640,0,200,480,Gosu::Color::GRAY,ZOrder::UI)
      x_offset = 5
      y_offset = 35
      x_between = 90
      y_between = 135
      for row in 0...3 #cardsPlaying.length/3
        for col in 0...7
          @blank_card.draw(x_offset + x_between*col,y_offset + y_between*row,ZOrder::CARDS, 0.15, 0.15)
        end
      end
    end
  end
end
