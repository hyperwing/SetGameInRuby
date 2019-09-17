# File Created 09/10/2019 by Neel Mansukhani
# Edited 09/15/2019 by Sharon Qiu
require 'gosu'
require_relative 'GameSettings'
require_relative 'card'
require_relative 'deck'

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

  attr_accessor :playerNumber, :currentCardIndex, :chosenCards, :chosenCardsIndexes

  def initialize playerNumber
    @currentCardIndex = 0 
    @playerNumber = playerNumber
    @chosenCards = Array.new
    @chosenCardsIndexes = Array.new
  end

  # Created 09/12/2019 by Sharon Qiu
  def move_left
    
    numCols = deck.length/3
    if (@currentCardIndex + 1)% numCols == 1
      @currentCardIndex += (numCols-1)
    else
      @currentCardIndex += 1
    end
  end

  # Created 09/12/2019 by Sharon Qiu
  def move_right

   numCols = deck.length/3
    if (@currentCardIndex + 1)% numCols == 0
      @currentCardIndex -= (numCols-1)
    else
      @currentCardIndex -= 1
    end
  end

  # Created 09/12/2019 by Sharon Qiu
  def move_up

    numCols = deck.length/3
    if @currentCardIndex - numcols < 0
      @currentCardIndex += 2 * numCols
    else
      @currentCardIndex -= numCols
    end
  end

  # Created 09/12/2019 by Sharon Qiu
  def move_down

    numCols = deck.length/3
    if @currentCardIndex + numcols > deck.length
      @currentCardIndex -= 2 * numCols
    else
      @currentCardIndex += numCols
    end
  end

  # Created 09/12/2019 by Sharon Qiu
  def selection 

    @chosenCardsIndexes.push @currentCardIndex
    @chosenCards.push playingCards[@currentCardIndex]
    if @chosenCards.length == 3
      # TODO: In the future, implement check for score adjustments with hint usage
      if isASet?(@chosenCards)
        # TODO: Change score, Print msg saying it is a set
      else
        # TODO: Print a message that says it is not a set.
      end
      @chosenCards.clear
  end

  # Created 09/12/2019 by Sharon Qiu: For future reference to hint functionality
  def hint
    
  end

end

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
    @deck = Deck.new
    @playingCards = Array.new
    @playersCreated = false

    #players
    @p1, @p2, @comp = nil, nil, nil
  end

  def update
    # Edited 09/15/2019 by Sharon Qiu: Edited game settings for gameplay selection.
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
        if @settings_hovered == "SOLO" 
          @game_settings.p1Init = true
          @game_settings.currentScreen = "levels" 
          @settings_hovered = Options::LEVELS_SCREEN[0]
        elsif @settings_hovered == "Computer"
          @game_settings.isCPUPlayerEnabled = true
          @game_settings.p1Init = true
          @game_settings.computerInit = true
        else
          @game_settings.isTwoPlayerEnabled = true
          @game_settings.p1Init = true
          @game_settings.p2Init = true
          @game_settings.currentScreen = "game"
          # TODO: Move Cursor
        end
      elsif button_up? Gosu::KB_E
        @game_settings.currentScreen = "test"
      end
    
    # Edited 09/15/2019 by Sharon Qiu: Edited game settings for levels.
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
      elsif Gosu.button_up? Gosu::KB_SPACE
          if @settings_hovered = "Easy"
            @game_settings.cpuDifficulty = "Easy"
          elsif @settings_hovered = "Medium"
            @game_settings.cpuDifficulty = "Medium"
          elsif @settings_hovered = "Hard"
            @game_settings.cpuDifficulty = "Hard"
          end

          @game_settings.currentScreen = "game"
          # TODO: Move cursor
      else
        #TODO: anything else?
      end
    elsif  @game_settings.currentScreen == "game"

      dealCards!(@deck,@cardsShowing)

      if Gosu.button_up? Gosu::KB_LEFT or Gosu.button_up? Gosu::KB_A
        @P1.move_left
      elsif Gosu.button_up? Gosu::KB_RIGHT or Gosu.button_up? Gosu::KB_D
        @P1.move_right
      elsif Gosu.button_up? Gosu::KB_UP or Gosu.button_up? Gosu::KB_W
        @P1.move_up
      elsif Gosu.button_up? Gosu::KB_DOWN or Gosu.button_up? Gosu::KB_S
        @P1.move_down
      elsif Gosu.button_up? Gosu::KB_SPACE or Gosu.button_up? Gosu::KB_RETURN
        @P1.selection 
      elsif Gosu.button_up? Gosu::KB_H 
        @P1.hint 
      end

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

  # Edited 09/15/2019 by Sharon Qiu: Set up cards based on number of cards played.
  # Edited 09/16/2019 by Sharon Qiu: Draws rectangles based on selections and current position.
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

      # Creates players if need be.
      if !@playersCreated
        #todo: make computer class
        # @comp = comp.new if game_settings.computerInit = true
        @p1 = Player(1).new if game_settings.p1Init = true
        @p2 = Player(2).new if game_settings.p2Init = true
        @playersCreated == true
      end
      
      # Set-up of maximum available cards
      draw_rect(640,0,200,480,Gosu::Color::GRAY,ZOrder::UI)
      
      # todo: conditions like hint conditions etc that tell you when to pop up
      # need booleans here to check if something's been pressed


      numCols = @playingCards.length / 3
      x_offset, y_offset, x_between, y_between = 5, 35, 90, 135
      for row in 0...3
        for col in 0...numCols #cardsPlaying.length/3
          @blank_card.draw(x_offset + x_between*col,y_offset + y_between*row,ZOrder::CARDS, 0.15, 0.15)
        end
      end

      #TO MOVE RECTANGLE:
      # X POSITION = @currentCardIndex % numCols
      # Y POSITION = @currentCardIndex / numCols

      if @game_settings.p1Init
        # Draws current position
        draw_rect(x_offset + (x_between/2)*(@p1.currentCardIndex  % numCols),y_offset + y_between*(@p1.currentCardIndex  / numCols),20,20,Gosu::Color::PLAYER_COLOR[@p1.playerNumber],ZOrder::CARDS)
        # Draws current selected values
        @p1.chosenCardsIndexes.each do |index|
          xpos, ypos = index % numCols, index / numCols
          draw_rect(x_offset + (x_between/2)*xpos,y_offset + y_between*ypos,20,20,Gosu::Color::PLAYER_COLOR[@p1.playerNumber],ZOrder::CARDS)
        end
      end

      if @game_settings.p2Init
        # Draws current position
        draw_rect(x_offset + (x_between/2)*(@p2.currentCardIndex  % numCols),y_offset + y_between*(@p2.currentCardIndex  / numCols),20,20,Gosu::Color::PLAYER_COLOR[@p2.playerNumber],ZOrder::CARDS)
        # Draws current selected values
        @p2.chosenCardsIndexes.each do |index|
          xpos, ypos = index % numCols, index / numCols
          draw_rect(x_offset + (x_between/2)*xpos,y_offset + y_between*ypos,20,20,Gosu::Color::PLAYER_COLOR[@p2.playerNumber],ZOrder::CARDS)
        end
      end

    end
  end
end

StartScreen.new.show
