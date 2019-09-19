# File Created 09/17/2019 by Neel Mansukhani
# File Edited 09/18/2019 by Neel Mansukhani
=begin
  This file contains functions for most input checks in the game.
  The input module is included in the Set class.
=end

# Edited 09/18/2019 by Neel Mansukhani: Put functions in the module
# Edited 09/18/2019 by Leah Gillespie: Added statistics and scores
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
        @game_settings.cpuDifficulty = "Easy"
      elsif @settings_hovered == "Medium"
        @game_settings.cpuDifficulty = "Medium"
      elsif @settings_hovered == "Hard"
        @game_settings.cpuDifficulty = "Hard"
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
  # Checks in game user input for one and two players
  def gameScreenInputs
    if button_up? Gosu::KB_A
      @p1.move_left @playingCards
      puts "p1: #{@p1.currentCardIndex}"
    elsif button_up? Gosu::KB_D
      @p1.move_right @playingCards
      puts "p1: #{@p1.currentCardIndex}"
    elsif button_up? Gosu::KB_W
      @p1.move_up @playingCards
      puts "p1: #{@p1.currentCardIndex}"
    elsif button_up? Gosu::KB_S
      @p1.move_down @playingCards
      puts "p1: #{@p1.currentCardIndex}"
    elsif button_up? Gosu::KB_SPACE
      @p1.selection @playingCards

      if @p1.chosenCardsIndexes.length == 3
        # TODO: In the future, implement check for score adjustments and stats with hint usage
        if isASet?(@p1.chosenCards)
	        @p1.setTimer.updateTime
          puts "Set found"
          @playingCards -= @p1.chosenCards
          @p1.chosenCards.clear #clears it so if selected cards were ones already chosen/found, it doesn't cause conflicts
          # TODO: Make a trigger for updating the window
	  @p1.setTimes.push @p1.setTimer.current
	  @p1.score += 1
	  @p1.setTimes.sort!
	  puts "Fastest time to find a set: #{@p1.setTimes.at 0}"
	  puts "Slowest time to find a set: #{@p1.setTimes.at -1}"
	  avgTime = 0
	  @p1.setTimes.each {|time| avgTime += time}
	  avgTime = avgTime / @p1.setTimes.length
	  puts "Average time to find a set: #{avgTime}"
	  #puts "Hints used so far: #{@p1.hintsUsed}"
	  @p1.setTimer.reset
        else
          puts "Set not found"
	  @p1.score -= 1
          # TODO: Make a trigger for updating the window
        end
        @p1.chosenCards.clear
        @p1.chosenCardsIndexes.clear
      end

      puts "p1: #{@p1.currentCardIndex}"
    elsif button_up? Gosu::KB_H
      @p1.hint
    end

    if button_up? Gosu::KB_LEFT
      @p2.move_left @playingCards
      puts "p2: #{@p2.currentCardIndex} "
    elsif button_up? Gosu::KB_RIGHT
      @p2.move_right @playingCards
      puts "p2: #{@p2.currentCardIndex} "
    elsif button_up? Gosu::KB_UP
      @p2.move_up @playingCards
      puts "p2: #{@p2.currentCardIndex} "
    elsif button_up? Gosu::KB_DOWN
      @p2.move_down @playingCards
      puts "p2: #{@p2.currentCardIndex} "
    elsif button_up? Gosu::KB_RETURN
      @p2.selection @playingCards

      if @p2.chosenCardsIndexes.length == 3
        # TODO: In the future, implement check for score adjustments and stats with hint usage
        if isASet?(@p2.chosenCards)
	        @p2.setTimer.updateTime
          puts "Set found"
          @playingCards -= @p2.chosenCards
          @p1.chosenCards.clear #clears it so if selected cards were ones already chosen/found, it doesn't cause conflicts
          # TODO: Make a trigger for updating the window
	  @p2.setTimes.push @p2.setTimer.current
	  @p2.score += 1
	  @p2.setTimes.sort!
	  puts "Fastest time to find a set: #{@p2.setTimes.at 0}"
	  puts "Slowest time to find a set: #{@p2.setTimes.at -1}"
	  avgTime = 0
	  @p2.setTimes.each {|time| avgTime += time}
	  avgTime = avgTime / @p2.setTimes.length
	  puts "Average time to find a set: #{avgTime}"
	  #puts "Hints used so far: #{@p2.hintsUsed}"
	  @p2.setTimer.reset
        else
          puts "Set not found"
	  @p2.score -=1
          # TODO: Make a trigger for updating the window
        end
        @p2.chosenCards.clear
        @p2.chosenCardsIndexes.clear
      end
      puts "p2: #{@p2.currentCardIndex} "
    end
  end
end


# Created 09/08/2019 by Sri Ramya Dandu
# Edited 09/09/2019 by Sri Ramya Dandu: Update and display deck and scores
# Edited 09/09/2019 by Sri Ramya Dandu: Modifed so that the computer can guess wrong sets too
# Edited 09/15/2019 by Sri Ramya Dandu: Added levels of difficulty
# Edited 09/15/2019 by Sri Ramya Dandu: changed arrays back to local variables
# Edited 09/17/2019 by Sri Ramya Dandu: removed threading features and modified for GUI output
def computerMove(p1)
  indexSet = Array.new

  found = false
  #generates 3 card index values
  winOrLose = rand(0..10)
  if winOrLose % 3 == 0
    #will always return 3 values that form a set
    indexSet = valid_table(@playingCards)
  else
    indexSet = (0...@playingCards.length).to_a.sample(3)
  end

  card1 = @playingCards[indexSet[0]]
  card2 = @playingCards[indexSet[1]]
  card3 = @playingCards[indexSet[2]]

# Output for Computer Player
# TODO: Output to UI instead of terminal
#
  puts "--------------------Computer Took A Turn------------------"
  puts "Computer Player: I chose Card #{card1.id}, Card #{card2.id}, and Card #{card3.id}"

  if(isASet?([card1,card2,card3]))
    puts("That is a set!")
    found = true
    @playingCards.delete(card1)
    @playingCards.delete(card2)
    @playingCards.delete(card3)
    p1.chosenCards.clear
    p1.chosenCardsIndexes.clear

  else
    puts("That is not a set.")
    found = false
  end

  puts "--------------------Computer Finished Turn------------------"
  puts

  return found

end
