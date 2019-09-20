# File Created 09/17/2019 by Neel Mansukhani
# Edited 09/18/2019 by Neel Mansukhani
# Edited 09/18/2019 by Leah Gillespie
# Edited 09/19/2019 by Sri Ramya Dandu
# Edited 09/19/2019 by Sharon Qiu
=begin
  This file contains functions for most input checks in the game.
  The input module is included in the Set class.
=end

# Edited 09/18/2019 by Neel Mansukhani: Put functions in the module
# Edited 09/18/2019 by Leah Gillespie: Added statistics and scores
# Edited 09/19/2019 by Sharon Qiu: moved computer into inputs module. Also added hint clearing when computer chooses a set.
module Inputs
  # Created 09/17/2019 by Neel Mansukhani
  # Checks the user inputs and allows user to select game mode
  def startScreenInputs
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
      @game_settings.changeGameMode @settings_hovered
      @settings_hovered = Options::LEVELS_SCREEN[0]
    end
  end
  # Created 09/17/2019 by Neel Mansukhani
  # Edited 09/19/2019 by Sri Ramya Dandu: Changed level attribute
  # Checks the user input and allows users to select CPU difficulty
  def levelsScreenInputs
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
      if @settings_hovered == "Easy"
        @game_settings.cpuDifficulty = 4
      elsif @settings_hovered == "Medium"
        @game_settings.cpuDifficulty = 2
      elsif @settings_hovered == "Hard"
        @game_settings.cpuDifficulty = 5
      end
      @game_settings.currentScreen = "game"
      # TODO: Move cursor
    elsif button_up? Gosu::KB_SPACE
      if @settings_hovered == "Easy"
        @game_settings.cpuDifficulty = "Easy"
        @computer_signal.level = 10
      elsif @settings_hovered == "Medium"
        @game_settings.cpuDifficulty = "Medium"
        @computer_signal.level = 50
      elsif @settings_hovered == "Hard"
        @game_settings.cpuDifficulty = "Hard"
        @computer_signal.level = 100
      end
    end
  end
  # Created 09/17/2019 by Sharon Qiu
  # Edited 09/17/2019 by Neel Mansukhani: Moved to Inputs Module
  # Edited 09/18/2019 by Neel Mansukhani: Removed isASet? from deck.
  # Edited 09/18/2019 by Leah Gillespie: adding statistics and score calculations
  # Edited 09/19/2019 by Sharon Qiu: Cleaned up movement checks.
  # Checks in game user input for one and two players
  def gameScreenInputs

    movementIndex = 0 # used to track switch cases
    if @game_settings.p1Init
      @p1.playerControls.each do |control|
        unless button_up? control
          movementIndex += 1
        else
          break
        end
      end

      # Determines movement
      case movementIndex
      when 0
        @p1.move_left @playingCards
        puts "p1 index: #{@p1.currentCardIndex}"
      when 1
        @p1.move_right @playingCards
        puts "p1 index: #{@p1.currentCardIndex}"
      when 2
        @p1.move_up @playingCards
        puts "p1 index: #{@p1.currentCardIndex}"
      when 3
        @p1.move_down @playingCards
        puts "p1 index: #{@p1.currentCardIndex}"
      when 4
        @p1.selection @playingCards
      else
        nil
      end

      # Checks the validity of a set.
      if @p1.chosenCardsIndexes.length == 3
        @p1.chosenSetValidity! @playingCards
        if @p1.setFound
          @hint.clear
          puts "Set found"
          @p2.cleanSlate if @game_settings.p2Init
	        @p1.setTimer.updateTime
          @p1.setTimes.push @p1.setTimer.current
          @p1.score += 1
          @p1.setTimes.sort!
	        @p1.timeSum += @p1.setTimer.current
          @p1.setTimer.reset
        else
          puts "Set not found"
          @p1.cleanSlate
	        @p1.score -= 1
        end
      end
    end

    movementIndex = 0
    if @game_settings.p2Init
      @p2.playerControls.each do |control|
        unless button_up? control
          movementIndex += 1
        else
          break
        end
      end

      # Determines movement
      case movementIndex
      when 0
        @p2.move_left @playingCards
        puts "p2 index: #{@p2.currentCardIndex}"
      when 1
        @p2.move_right @playingCards
        puts "p2 index: #{@p2.currentCardIndex}"
      when 2
        @p2.move_up @playingCards
        puts "p2 index: #{@p2.currentCardIndex}"
      when 3
        @p2.move_down @playingCards
        puts "p2 index: #{@p2.currentCardIndex}"
      when 4
        @p2.selection @playingCards
      else
        nil
      end

      # Checks the validity of a set.
      if @p2.chosenCardsIndexes.length == 3
        @p2.chosenSetValidity! @playingCards
        if @p2.setFound
          puts "Set found"
          @p1.cleanSlate if @game_settings.p1Init
	        @p2.setTimer.updateTime
          @p2.setTimes.push @p2.setTimer.current
          @p2.score += 1
          @p2.setTimes.sort!
	        @p2.timeSum += @p2.setTimer.current
          @p2.setTimer.reset
        else
          puts "Set not found"
          @p2.cleanSlate
          @p2.score -=1
        end
      end
    end

    # Check if table valid
    if @deck.deckCount < 9 and valid_table(@playingCards).length == 0
      # puts("no more sets")
      @game_settings.currentScreen = "gameover"
      return
    end

    if @game_settings.areHintsEnabled and button_up? Gosu::KB_H
      @hint = @p1.get_hint @playingCards
    end
  end
end

# Created 9/18/19 David Wing
# Checks inputs when player hits gameover screen
def gameOverScreenInputs
  index = Options::GAMEOVER_SCREEN.find_index @settings_hovered
  if button_up? Gosu::KB_D
    if index == 1
      @settings_hovered = Options::GAMEOVER_SCREEN[0]
    else
      index += 1
      @settings_hovered = Options::GAMEOVER_SCREEN[index]
    end
  elsif button_up? Gosu::KB_A
    if index == 0
      @settings_hovered = Options::GAMEOVER_SCREEN[2]
    else
      index -= 1
      @settings_hovered = Options::GAMEOVER_SCREEN[index]
    end
  elsif button_up? Gosu::KB_SPACE

    if  index == 0
    # Choose home
      # @game_settings.currentScreen = StartScreen
      StartScreen.new.show

    else 
      close
    end

  end
end

# Created 09/08/2019 by Sri Ramya Dandu
# Edited 09/09/2019 by Sri Ramya Dandu: Update and display deck and scores
# Edited 09/09/2019 by Sri Ramya Dandu: Modifed so that the computer can guess wrong sets too
# Edited 09/15/2019 by Sri Ramya Dandu: changed arrays back to local variables
# Edited 09/17/2019 by Sri Ramya Dandu: removed threading features and modified for GUI output
# Edited 09/19/2019 by Sharon Qiu: replaced p1 card clearing with method clean slate.
# Edited 09/19/2019 by Sri Ramya Dandu: Added levels of difficulty and message options
def computerMove p1
  indexSet = Array.new

  # Created 09/08/2019 by Sri Ramya Dandu
  # Edited 09/09/2019 by Sri Ramya Dandu: Update and display deck and scores
  # Edited 09/09/2019 by Sri Ramya Dandu: Modifed so that the computer can guess wrong sets too
  # Edited 09/15/2019 by Sri Ramya Dandu: changed arrays back to local variables
  # Edited 09/17/2019 by Sri Ramya Dandu: removed threading features and modified for GUI output
  # Edited 09/19/2019 by Sharon Qiu: replaced p1 card clearing with method clean slate.
  # Edited 09/19/2019 by Sri Ramya Dandu: Added levels of difficulty and message options
  def computerMove p1
    indexSet = Array.new

    #found = 0 for wrong output, 1 for right output, 2 for still trying
    found = 0

    if @playingCards.length > 3
      #generates 3 card index values
      winOrLose = rand(0..9)
      # Easy mode: 30% chance of correct answer
      # Medium mode: 50% chance of correct answer
      # Hard mode: 80% chance of correct answer
      #will always return 3 values that form a set
      if winOrLose % @game_settings.cpuDifficulty == 0
        indexSet = valid_table(@playingCards)
      elsif @game_settings.cpuDifficulty == 5 && winOrLose % 3 == 0
        indexSet = valid_table(@playingCards)
      else
        indexSet = (0...@playingCards.length).to_a.sample(3)
      end

      card1 = @playingCards[indexSet[0]]
      card2 = @playingCards[indexSet[1]]
      card3 = @playingCards[indexSet[2]]


      if(isASet?([card1,card2,card3]))
        @hint.clear
        found = 1
        @playingCards.delete(card1)
        @playingCards.delete(card2)
        @playingCards.delete(card3)
        p1.cleanSlate
        @computer_signal.score += 1
      else
        found = 0
        @computer_signal.score -= 1
      end
      #determines if false or still trying should print
      if found == 0 && rand(0..2) == 0
        found = 2
        @computer_signal.score += 1
      end
    end
    return found
  end
end
