# File Created 09/10/2019 by Neel Mansukhani
require 'gosu'
require_relative 'GameSettings'
require_relative "card"

module ZOrder
  BACKGROUND, UI, BUTTON, TEXT, CARDS= *0..4
end

module Options
  START_SCREEN = ["SOLO", "Computer", "2 Player"]
  LEVELS_SCREEN = ["Easy", "Medium", "Hard"]
end

GAME_TITLE = "The Game of Set"

class StartScreen < Gosu::Window
  def initialize
    @game_settings = GameSettings.new
    super 840, 480
    self.caption = GAME_TITLE
    @settings_hovered = Options::START_SCREEN[0]
    @pressed = nil
    @title_font = Gosu::Font.new(50)
    @subtitle_font = Gosu::Font.new(20)
    @background_image = Gosu::Image.new("media/background1.jpg", :tileable => true)
    @blank_card = Gosu::Image.new("media/card.png", :tileable => true)
    @buttonOption = Gosu::Image.new("media/button.png", :tileable => true)
  end

  def update
    close if button_up? Gosu::KB_ESCAPE
    if @game_settings.currentScreen == "start"
      index = Options::START_SCREEN.find_index @settings_hovered
      if button_up? Gosu::KB_D
        if index == 2
          @settings_hovered = Options::START_SCREEN[0]
        else
          index += 1
          @settings_hovered = Options::START_SCREEN[index]
        end
      elsif button_up? Gosu::KB_A
        if index == 0
          @settings_hovered = Options::START_SCREEN[2]
        else
          index -= 1
          @settings_hovered = Options::START_SCREEN[index]
        end
      elsif button_up? Gosu::KB_SPACE
        if @settings_hovered == "Computer" or @settings_hovered == "SOLO"
          @game_settings.currentScreen = "levels"
          @settings_hovered = Options::LEVELS_SCREEN[0]
        else
          @game_settings.currentScreen = "game"
          # TODO: Move Cursor
        end
      elsif button_up? Gosu::KB_E
        @game_settings.currentScreen = "test"
      end
    elsif @game_settings.currentScreen =="levels"
      index = Options::LEVELS_SCREEN.find_index @settings_hovered
      if button_up? Gosu::KB_S
        if index == 2
          @settings_hovered = Options::LEVELS_SCREEN[0]
        else
          index += 1
          @settings_hovered = Options::LEVELS_SCREEN[index]
        end
      elsif button_up? Gosu::KB_W
        if index == 0
          @settings_hovered = Options::LEVELS_SCREEN[2]
        else
          index -= 1
          @settings_hovered = Options::LEVELS_SCREEN[index]
        end
      elsif button_up? Gosu::KB_SPACE
        @game_settings.currentScreen = "game"
        # TODO: Move cursor
      end
    elsif  @game_settings.currentScreen == "game"

    end
  end
  def button_up? id
    button = button_down? id
    if @pressed != id and @pressed != nil
      return false
    end
    if button and @pressed != id
      @pressed = id
      return true
    elsif !button
      @pressed = nil
    end
    return false
  end
  #Created by Sri Ramya Dandu
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
  def draw
    @background_image.draw(0, 0, ZOrder::BACKGROUND)
    if @game_settings.currentScreen == "start"
      startScreen
    elsif @game_settings.currentScreen == "levels"
      levelsScreen
    elsif @game_settings.currentScreen == "test"
      x = Card.new(0,2,0,1,1)
      x.image.draw(0,0,ZOrder::CARDS, 0.15, 0.15)
    elsif  @game_settings.currentScreen == "game"
      draw_rect(640,0,200,480,Gosu::Color::GRAY,ZOrder::UI)
      x_offset = 5
      y_offset = 35
      x_between = 90
      y_between = 135
      for row in 0...3
        for col in 0...7 #cardsPlaying.length/3
          @blank_card.draw(x_offset + x_between*col,y_offset + y_between*row,ZOrder::CARDS, 0.15, 0.15)
        end
      end
    end
  end
end

StartScreen.new.show
