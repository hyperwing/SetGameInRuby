# File Created 09/10/2019 by Neel Mansukhani
# Edited 09/15/2019 by Sharon Qiu
require 'gosu'
require_relative 'GameSettings'
require_relative "Card"

module ZOrder
  BACKGROUND, UI, BUTTON, TEXT, CARDS= *0..4
end

# Edited 09/15/2019 by Sharon Qiu: Added PLAYER_COLOR, where Gray is computer, red is player1, blue is player2.
module Options
  START_SCREEN = ["SOLO", "Computer", "2 Player"]
  PLAYER_COLOR = ["GRAY", "RED", "BLUE"]
  LEVELS_SCREEN = ["Easy", "Medium", "Hard"]
  
end

GAME_TITLE = "The Game of Set"

# Created 09/12/2019 by Sharon Qiu: Skeleton code for player movement only within the game.
# Edited 09/15/2019 BY Sharon Qiu: merged in player class into StartScreen file.
class Player

  attr_accessor :selectedSet

  def initialize playerNumber
    @currentCard = draw_rect(50,35+(135/2),20,20,Gosu::Color::PLAYER_COLOR[playerNumber],ZOrder::CARDS)
  end

  # Created 09/12/2019 by Sharon Qiu
  # Updates/keeps track of player score
=begin   def scoreUpdate set, hint_used
      setFound = isASet? set
      return "#{}" if !setFound # TODO: Add to codeblock something to return if invalid set
      if hint_used && setFound
        @score += 0.5
      elsif setFound
        @score += 1
      end
  end 
=end

  # Created 09/12/2019 by Sharon Qiu
  def move_left
    # Fill in when we know set up of cards
    # Offsets depending on card positions
  end

  # Created 09/12/2019 by Sharon Qiu
  def move_right
    # Fill in when we know set up of cards
    # Offsets depending on card positions
  end

  # Created 09/12/2019 by Sharon Qiu
  def move_up
    # Fill in when we know set up of cards
    # Offsets depending on card positions
  end

  # Created 09/12/2019 by Sharon Qiu
  def move_down
    # Fill in when we know set up of cards
    # Offsets depending on card positions
  end

  # Created 09/12/2019 by Sharon Qiu
  def selection chosenCards = nil
    # chosenCards is selected cards
    # @currentSelected = position
    # chosenCards.push(@currentSelected)

    # Fill in when we know set up of cards
    # will probably have to highlight cards, kept track of chosen cards by array
  end
end

class StartScreen < Gosu::Window
  def initialize
    @game_settings = GameSettings.new
    super 840, 480
    self.caption = GAME_TITLE
    @settings_hovered = Options::START_SCREEN[0]
    @pressed = false
    @title_font = Gosu::Font.new(50)
    @subtitle_font = Gosu::Font.new(20)
    @background_image = Gosu::Image.new("media/background1.jpg", :tileable => true)
    @blank_card = Gosu::Image.new("media/card.png", :tileable => true)
    @buttonOption = Gosu::Image.new("media/button.png", :tileable => true)
  end

  def update

    # Edited 09/15/2019 by Sharon Qiu: Edited game settings for gameplay selection.
    if @game_settings.currentScreen == "start"
      index = Options::START_SCREEN.find_index @settings_hovered
      if button_down? Gosu::KB_D
        if index == 2
          @settings_hovered = Options::START_SCREEN[0]
        else
          index += 1
          @settings_hovered = Options::START_SCREEN[index]
        end
        sleep(0.5)
      elsif Gosu.button_down? Gosu::KB_A
        if index == 0
          @settings_hovered = Options::START_SCREEN[2]
        else
          index -= 1
          @settings_hovered = Options::START_SCREEN[index]
        end
        sleep(0.5)
      elsif Gosu.button_down? Gosu::KB_SPACE
        if @settings_hovered == "SOLO" 
          @game_settings.currentScreen = "levels"
          @settings_hovered = Options::LEVELS_SCREEN[0]
        elsif @settings_hovered == "Computer"
          @game_settings.isCPUPlayerEnabled = true
          @game_settings.currentScreen = "levels"
          @settings_hovered = Options::LEVELS_SCREEN[0]
        else
          @game_settings.isTwoPlayerEnabled = true
          @game_settings.currentScreen = "game"
          # TODO: Move Cursor
        end
        sleep(0.5)
      else
      end
    
    # Edited 09/15/2019 by Sharon Qiu: Edited game settings for levels.
    elsif @game_settings.currentScreen =="levels"
      index = Options::LEVELS_SCREEN.find_index @settings_hovered
      if button_down? Gosu::KB_S
        if index == 2
          @settings_hovered = Options::LEVELS_SCREEN[0]
        else
          index += 1
          @settings_hovered = Options::LEVELS_SCREEN[index]
        end
        sleep(0.5)
      elsif Gosu.button_down? Gosu::KB_W
        if index == 0
          @settings_hovered = Options::LEVELS_SCREEN[2]
        else
          index -= 1
          @settings_hovered = Options::LEVELS_SCREEN[index]
        end
        sleep(0.5)
      elsif Gosu.button_down? Gosu::KB_SPACE
          if @settings_hovered = "Easy"
            @game_settings.cpuDifficulty = "Easy"
          elsif @settings_hovered = "Medium"
            @game_settings.cpuDifficulty = "Medium"
          elsif @settings_hovered = "Hard"
            @game_settings.cpuDifficulty = "Hard"
          end

          @game_settings.currentScreen = "game"
          # TODO: Move cursor
        sleep(0.5)
      else
        #TODO: anything else?
      end
    elsif  @game_settings.currentScreen == "game"
      

    end
  end

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

  def activeGame gameMode
    if gameMode == startScreen[0]
      @player1 = Player.new 1
    elsif gameMode == startScreen[1]
      @comp = Player.new 0
      @player1 = Player.new 1
    elsif gameMode == startScreen[2]
      @player1 = Player.new 1
      @player2 = Player.new 2
    end
  end

  def draw
    @background_image.draw(0, 0, ZOrder::BACKGROUND)
    if @game_settings.currentScreen == "start"
      startScreen
    elsif @game_settings.currentScreen =="levels"
      levelsScreen
    elsif  @game_settings.currentScreen == "game"
      draw_rect(640,0,200,480,Gosu::Color::GRAY,ZOrder::UI)
      x_offset, y_offset, x_between, y_between = 5, 35, 90, 135
      for row in 0...3
        for col in 0...7 #cardsPlaying.length/3
          @blank_card.draw(x_offset + x_between*col,y_offset + y_between*row,ZOrder::CARDS, 0.15, 0.15)
        end
      end
    end
  end
end

StartScreen.new.show
