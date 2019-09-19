# File Created 09/10/2019 by Neel Mansukhani
# Edited 09/15/2019 by Sharon Qiu
# Edited 09/17/2019 by Sharon Qiu
# Edited 09/17/2019 by Sri Ramya Dandu
# Edited 09/18/2019 by Sri Ramya Dandu

require 'gosu'
require_relative 'GameSettings'
require_relative 'card'
require_relative 'deck'
require_relative 'Draws'
require_relative 'Player'
require_relative 'Inputs'
require_relative 'Set'
require_relative 'ComputerTimer'

module ZOrder
  BACKGROUND, UI, BUTTON, TEXT, CARDS= *0..4
end

# Edited 09/15/2019 by Sharon Qiu: Added PLAYER_COLOR, where Gray is computer, red is player1, blue is player2.
module Options
  START_SCREEN = ["SOLO", "Computer", "2 Player"]
  LEVELS_SCREEN = ["Easy", "Medium", "Hard"]
end

GAME_TITLE = "The Game of Set"


class StartScreen < Gosu::Window
  # Edited 09/18/2019 by Neel Mansukhani: Moved methods to modules.
  include Inputs, Draws

  # Edited 09/14/2019 by Sri Ramya Dandu: changed background and added buttons
  # Edited 09/17/2019 by Sharon Qiu: added in deck, playingcards, and playersCreated, as well as p1,p2,comp.
  # Edited 09/17/2019 by Sri Ramya Dandu: added computer timer
  # Edited 09/18/2019 by Sri Ramya Dandu: Added booleans to track when message is printed
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
    @deck = Deck.new
    @playingCards = Array.new
    @playersCreated = false
    @computer_signal = ComputerTimer.new(20)
    @mes,@false_mes,@true_mes = false,false,false

    #players
    @p1, @p2, @comp = nil, nil, nil
  end
  # Edited 09/15/2019 by Sharon Qiu: Edited game settings for gameplay selection, game settings for levels.
  # Edited 09/17/2019 by Sharon Qiu: Edited game screen checks. Split commands into p1 and p2.
  # Edited 09/17/2019 by Sri Ramya Dandu: Added computer functionality
  def update
    if @game_settings.currentScreen == "start"
      startScreenInputs
    elsif @game_settings.currentScreen =="levels"
      levelsScreenInputs
    elsif  @game_settings.currentScreen == "game"
      if @game_settings.isCPUPlayerEnabled
        @computer_signal.level = 100
        if @computer_signal.update
          @mes = computerMove(@p1)
        end
        @true_mes = @mes && @computer_signal.display_message?
        @false_mes = !@mes && @computer_signal.display_message?
      end
      gameScreenInputs
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




  # Edited 09/15/2019 by Sharon Qiu: Set up cards based on number of cards played.
  # Edited 09/16/2019 by Sharon Qiu: Draws rectangles based on selections and current position.
  # Edited 09/17/2019 by Sharon Qiu: Added check for player type.
  # Edited 09/18/2019 by Sri Ramya Dandu: Added output for computer to GUI
  def draw

    @background_image.draw(0, 0, ZOrder::BACKGROUND)
    if @game_settings.currentScreen == "start"
      startScreen
    elsif @game_settings.currentScreen == "levels"
      levelsScreen
    elsif @game_settings.currentScreen == "test"
      x = Card.new(0,2,0,2,2)
      x.image.draw(0,0,ZOrder::CARDS, 0.15, 0.15)
    elsif  @game_settings.currentScreen == "game"

      @deck.dealCards! @playingCards

      if @game_settings.isCPUPlayerEnabled
        @computer_signal.level = 100
      end

      if @true_mes
        @subtitle_font.draw_text("Computer:", 645, 215, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
        @subtitle_font.draw_text("I found a set!", 645, 245, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
      end

      if @false_mes
        @subtitle_font.draw_text("Computer:", 645, 215, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
        @subtitle_font.draw_text("Oops not a set!", 645, 245, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK)
      end

      # Creates players if need be.
      if !@playersCreated
        @p1 = Player.new if @game_settings.p1Init == true
        @p2 = Player.new if @game_settings.p2Init == true
        @playersCreated = true

      end

      Gosu.draw_rect(640,0,200,480,Gosu::Color::GRAY,ZOrder::UI)
      
      # todo: conditions like hint conditions etc that tell you when to pop up
      # need booleans here to check if something's been pressed

      c = 0
      numCols = @playingCards.length / 3
      x_offset, y_offset, x_between, y_between = 5, 35, 90, 135
      for row in 0...3
        for col in 0...numCols #cardsPlaying.length/3
          @playingCards[c].image.draw(x_offset + x_between*col,y_offset + y_between*row,ZOrder::CARDS, 0.15, 0.15)
          c += 1
        end
      end

      #TO MOVE RECTANGLE:
      # X POSITION = @currentCardIndex % numCols
      # Y POSITION = @currentCardIndex / numCols

      if @game_settings.p1Init

        # Draws current position
        if @p1.currentCardIndex % numCols == 0 or (@p1.currentCardIndex % numCols == 1 and @p1.currentCardIndex >= numCols-1)
          draw_rect((x_between/2)*((@p1.currentCardIndex % numCols)+1),(y_between/2)*((@p1.currentCardIndex  / numCols)+1),20,20,Gosu::Color::BLUE,ZOrder::CARDS)
        else
          draw_rect((x_between/1.85)*((@p1.currentCardIndex % numCols)+1),(y_between/2)*((@p1.currentCardIndex  / numCols)+1),20,20,Gosu::Color::BLUE,ZOrder::CARDS)
        end

        # Draws current selected values
        @p1.chosenCardsIndexes.each {|index| draw_rect((x_between/1.85)*((index % numCols)+1),(y_between/2)*((index / numCols)+1),20,20,Gosu::Color::BLUE,ZOrder::CARDS)}
      end

      if @game_settings.p2Init

        # Draws current position
        if @p2.currentCardIndex % numCols == 0 or (@p2.currentCardIndex % numCols == 1 and @p2.currentCardIndex >= numCols-1)
          draw_rect((x_between/2)*((@p2.currentCardIndex % numCols)+1),(y_between/2)*((@p2.currentCardIndex  / numCols)+1),20,20,Gosu::Color::RED,ZOrder::CARDS)
        else
          draw_rect((x_between/1.85)*((@p2.currentCardIndex % numCols)+1),(y_between/2)*((@p2.currentCardIndex  / numCols)+1),20,20,Gosu::Color::RED,ZOrder::CARDS)
        end

        # Draws current selected values
        @p2.chosenCardsIndexes.each {|index| draw_rect((x_between/1.85)*((index % numCols)+1),(y_between/2)*((index / numCols)+1),20,20,Gosu::Color::RED,ZOrder::CARDS)}

      end

    end
  end
end

StartScreen.new.show
