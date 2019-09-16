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

  attr_accessor :currentCard, :currentCardIndex, :chosenCards, :chosenCardsIndexes

  def initialize playerNumber
    @currentCardIndex = 0 # Kept this as 0 because idk if we'll need to access cards directly in the future, can be changed to 1 later
    @currentCard = draw_rect(50,35+(135/2),20,20,Gosu::Color::PLAYER_COLOR[playerNumber],ZOrder::CARDS)
    @chosenCards = Array.new
    @chosenCardsIndexes = Array.new
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
    if @currentCardIndex + numcols >deck.length
      @currentCardIndex -= 2 * numCols
    else
      @currentCardIndex += numCols
    end

  end


  #TO MOVE RECTANGLE:
    # X POSITION = @currentCardIndex % numCols
    # Y POSITION = @currentCardIndex / numCols

  # Created 09/12/2019 by Sharon Qiu
  def selection chosenCards

    chosenCardsIndexes.push @currentCardIndex
    chosenCards.push playingCards[@currentCardIndex]
    if chosenCards.length == 3

      # TODO: In the future, implement check for score adjustments with hint usage
      if isASet?(chosenCards)
        # TODO: Change score, Print msg saying it is a set

      else
        # TODO: Print a message that says it is not a set.
        chosenCards.clear

    # Fill in when we know set up of cards
    # will probably have to highlight cards, kept track of chosen cards by array
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
    @pressed = false
    @threadsCreated = false
    @title_font = Gosu::Font.new(50)
    @subtitle_font = Gosu::Font.new(20)
    @background_image = Gosu::Image.new("media/background1.jpg", :tileable => true)
    @blank_card = Gosu::Image.new("media/card.png", :tileable => true)
    @buttonOption = Gosu::Image.new("media/button.png", :tileable => true)
    @deck = dealCards
    @playingCards = Array.new
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
          @game_settings.p1Init = true
          @game_settings.currentScreen = "levels" 
          @settings_hovered = Options::LEVELS_SCREEN[0]
        elsif @settings_hovered == "Computer"
          @game_settings.isCPUPlayerEnabled = true
          @game_settings.p1Init = true
          @game_settings.computerInit = true
          @game_settings.currentScreen = "levels"
          @settings_hovered = Options::LEVELS_SCREEN[0]
        else
          @game_settings.isTwoPlayerEnabled = true
          @game_settings.p1Init = true
          @game_settings.p2Init = true
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

      dealCards!(@deck,@cardsShowing)




    end
  end

  #Created 09/08/2019 by Sri Ramya Dandu
  #Edited 09/12/2019 by Leah Gillespie: Adding player statistics
  # Edited 09/15/2019 by Sri Ramya Dandu: changed arrays back to local variables
  def playerThrd(deck,cardsShowing,playerNum)

    sets = Array.new
    while true

      #changes signal to false to prevent computer thread from printing its cards
      $signal = false
      dealCards(deck,cardsShowing)

      #Displays cards
      cardsShowing.each { |card| card.display }
      $signal = true

      valid_set = valid_table(cardsShowing)

      # no valid sets
      break if valid_set.length == 0 && deck.length == 0

      # No checks for valid input because we plan to implement a GUI.


      print("Need a hint? y/n: ")
      input = gets.chomp
      if input.eql? "y"
        $p1Hints += 1
        get_hint(valid_set,cardsShowing)
      end

      print("Enter your 3 card numbers, separated by a comma: ")
      strInput = gets
      comma = strInput.index(",")
      card1 = strInput[0,comma].to_i
      strInput = strInput[comma+1,strInput.length]
      comma = strInput.index(",")
      card2 = strInput[0,comma].to_i
      strInput = strInput[comma+1,strInput.length]
      card3 = strInput[0,strInput.length].to_i
      set = [getCardById(cardsShowing,card1),getCardById(cardsShowing,card2),getCardById(cardsShowing,card3)]

      if(isASet?(set))
        $p1SetTimer.updateTime
        $p1SetTimes.push $p1SetTimer.current
        puts "That is a set!"
        #TODO: Score should increment/decrement here
        $playerScore += 1
        #TODO: set up hash or something to clean sets up.
        sets.push(set)
        $p1SetTimes.sort!
        puts "Fastest time to find a set: #{$p1SetTimes.at(0)}"
        puts "Slowest time to find a set: #{$p1SetTimes.at($p1SetTimes.length-1)}"
        avgTime = 0
        $p1SetTimes.each {|time| avgTime += time}
        avgTime = avgTime / $p1SetTimes.length
        puts "Average time to find a set: #{avgTime}"
        puts "Hints used so far: #{$p1Hints}"
        $p1SetTimer.reset
        cardsShowing.delete(set[0])
        cardsShowing.delete(set[1])
        cardsShowing.delete(set[2])
      else
        puts "That is not a set."
        $playerScore -= 1
      end

      puts "Computer score: #{$computerScore}"
      puts "Your current score: #{$playerScore}"
      $gameTimer.updateTime
      puts "Total elapsed time: #{$gameTimer.current}"
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

  def printRect selected

    for i in selected.length
      selected[i]
    end


    # if gameMode == startScreen[0]
    #   @player1 = Player.new 1
    # elsif gameMode == startScreen[1]
    #   @comp = Player.new 0
    #   @player1 = Player.new 1
    # elsif gameMode == startScreen[2]
    #   @player1 = Player.new 1
    #   @player2 = Player.new 2
    # end
  end


  def draw
    @background_image.draw(0, 0, ZOrder::BACKGROUND)
    if @game_settings.currentScreen == "start"
      startScreen
    elsif @game_settings.currentScreen =="levels"
      levelsScreen
    elsif  @game_settings.currentScreen == "game"

      # Creates threads if need be.
      if !threadsCreated
        comp = thread.new(playerThrd(deck, cardsShowing, 0)) if game_settings.computerInit = true
        p1 = thread.new(playerThrd(deck, cardsShowing, 1)) if game_settings.p1Init = true
        p2 = thread.new(playerThrd(deck, cardsShowing, 2)) if game_settings.p2Init = true
        threadsCreated == true
      end
      
      # Set-up of maximum available cards
      # Edited 09/15/2019 by Sharon Qiu: Set up cards based on number of cards played.
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

      


    end
  end
end

StartScreen.new.show
