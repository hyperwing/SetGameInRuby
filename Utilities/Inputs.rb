# File Created 09/17/2019 by Neel Mansukhani
# Edited 09/18/2019 by Neel Mansukhani
# Edited 09/18/2019 by Leah Gillespie
# Edited 09/19/2019 by Sri Ramya Dandu
# Edited 09/19/2019 by Sharon Qiu
# Edited 09/20/2019 by Sharon Qiu
# This file contains functions for most input checks in the game.
# The input module is included in the Set class.

# Edited 09/18/2019 by Neel Mansukhani: Put functions in the module
# Edited 09/18/2019 by Leah Gillespie: Added statistics and scores
# Edited 09/19/2019 by Sharon Qiu: moved computer into inputs module. Also added hint clearing when computer chooses a set.

# TODO: refractor startScreenInputs, levelsScreenInputs, gameScreenInputs, gameOverScreenInputs
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
        @game_settings.cpuDifficulty = 1
      elsif @settings_hovered == "Medium"
        @game_settings.cpuDifficulty = 4
      elsif @settings_hovered == "Hard"
        @game_settings.cpuDifficulty = 10
      end
      @game_settings.currentScreen = "game"
    end
  end
  # Created 09/17/2019 by Sharon Qiu
  # Edited 09/17/2019 by Neel Mansukhani: Moved to Inputs Module
  # Edited 09/18/2019 by Neel Mansukhani: Removed isASet? from deck.
  # Edited 09/18/2019 by Leah Gillespie: adding statistics and score calculations
  # Edited 09/19/2019 by Sharon Qiu: Cleaned up movement checks.
  # Edited 09/20/2019 by Sharon Qiu: Condensed player inputs by passing in player.
  # Checks in game user input for one and two players
  def gameScreenInputs player

    movement_index = 0 # used to track switch cases
    if @game_settings.p1Init
      player.playerControls.each do |control|
        unless button_up? control
          movement_index += 1
        else
          break
        end
      end

      # Determines movement
      case movement_index
      when 0
        player.move_left @playingCards
      when 1
        player.move_right @playingCards
      when 2
        player.move_up @playingCards
      when 3
        player.move_down @playingCards
      when 4
        player.selection @playingCards
      else
        nil
      end

      # Checks the validity of a set.
      if player.chosenCardsIndexes.length == 3
        player.chosenSetValidity! @playingCards
        if player.setFound
          @hint.clear
	  player.setTimer.updateTime
          player.setTimes.push player.setTimer.current
          player.score += 1
          player.setTimes.sort!
	  player.timeSum += player.setTimer.current
          player.setTimer.reset
        else
          player.cleanSlate
	  player.score -= 1
        end
      end
    end

    # Check if table valid
    if @deck.deckCount < 9 and valid_table(@playingCards).length == 0

      @game_settings.currentScreen = "gameover"
      @settings_hovered = Options::GAMEOVER_SCREEN[0]
      return
    end

    if @game_settings.areHintsEnabled and button_up? Gosu::KB_H
      @hint = player.get_hint @playingCards
    end
  end

	# Created 9/18/19 David Wing
	# Edited 9/19/19 David Wing: fixed bug causing crash on index nil
	# Checks inputs when player hits gameover screen
	def gameOverScreenInputs
		index = Options::GAMEOVER_SCREEN.find_index @settings_hovered
		index = 0 if index.nil?
		
		if button_up? Gosu::KB_D
		  index += 1
		  index = 0 if index == 2
		  @settings_hovered = Options::GAMEOVER_SCREEN[index]
		  
		elsif button_up? Gosu::KB_A
		  index-=1
		    index = 1 if index == -1
		  @settings_hovered = Options::GAMEOVER_SCREEN[index]

		elsif button_up? Gosu::KB_SPACE

		  if  index == 0
		    # Choose home
		    @game_settings.changeGameMode "gameover"
		    @game_settings.currentScreen = "start"
		    @settings_hovered = Options::START_SCREEN[0]
		    SetGame.new.show
		  else 
		    close
		    exit 0
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
		    winOrLose = rand 0..@game_settings.cpuDifficulty
		    # Easy mode: 50% chance of correct answer
		    # Medium mode: 80% chance of correct answer
		    # Hard mode: 100% chance of correct answer
		    #will always return 3 values that form a set
		    if @game_settings.cpuDifficulty == 10
		      indexSet = valid_table @playingCards
		    elsif  winOrLose == 0
		      indexSet = (0...@playingCards.length).to_a.sample 3
		    else
		      indexSet = valid_table @playingCards
		    end

		    card1 = @playingCards[indexSet[0]]
		    card2 = @playingCards[indexSet[1]]
		    card3 = @playingCards[indexSet[2]]


		    if(isASet? [card1,card2,card3])
		      @hint.clear
		      found = 1
		      @playingCards.delete card1
		      @playingCards.delete card2
		      @playingCards.delete card3
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
end
