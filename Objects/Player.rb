# File Created 09/17/2019 by Neel Mansukhani
# Edited 09/15/2019 by Sharon Qiu
# Edited 09/17/2019 by Sharon Qiu
# Edited 09/18/2019 by Sharon Qiu
# Edited 09/19/2019 by Sharon Qiu

# Created 09/12/2019 by Sharon Qiu: Skeleton code for player movement only within the game.
# Edited 09/15/2019 by Sharon Qiu: merged in player class into StartScreen file.
# Edited 09/17/2019 by Sharon Qiu: Edited all player movement functions.
# Edited 09/18/2019 by Sharon Qiu: Introduced parallel mapping keys.
# Edited 09/18/2019 by Leah Gillespie: Added player stats and score as instance variables
# Edited 09/18/2019 by Sharon Qiu: Included setFunctions module. Also moved get_hint into player class. Also created 2 new functions, chosen set validity and clean slate.
# Edited 09/19/2019 by Sharon Qiu: Modified get_hint to return indices of a found set.
# Edited 09/20/2019 by Leah Gillespie: Ensured hints used is being tracked
class Player

  include SetFunctions
  attr_accessor :currentCardIndex, :chosenCards, :chosenCardsIndexes,
                :playerControls, :playerMovement, :setTimer, :setTimes,
                :hintsUsed, :score, :timeSum, :setFound

  @@p1Controls = [Gosu::KB_A, Gosu::KB_D, Gosu::KB_W, Gosu::KB_S, Gosu::KB_SPACE]
  @@p2Controls = [Gosu::KB_LEFT, Gosu::KB_RIGHT, Gosu::KB_UP, Gosu::KB_DOWN, Gosu::KB_RETURN]

  def initialize playerNum

    @playerControls = @@p1Controls if playerNum == 1
    @playerControls = @@p2Controls if playerNum == 2

    @currentCardIndex = 0
    @chosenCards = Array.new
    @chosenCardsIndexes = Array.new
    @setTimer = AllTimers.new
    @setTimes = Array.new
    @timeSum = 0
    @hintsUsed = 0
    @setFound = false
    @score = 0

  end

  # Created 09/12/2019 by Sharon Qiu
  # Edited 09/17/2019 by Sharon Qiu: Created conditions for movement leftwards.
  def move_left playingCards

    numCols = playingCards.length/3
    if @currentCardIndex % numCols == 0 and @currentCardIndex < playingCards.length
      @currentCardIndex += (numCols-1)
    else
      @currentCardIndex -= 1
    end
  end

  # Created 09/12/2019 by Sharon Qiu
  # Edited 09/17/2019 by Sharon Qiu: Created conditions for movement rightwards.
  # Edited 09/19/2019 by Sharon Qiu: Edited movement so that it accounted for number of columns.
  def move_right playingCards

    numCols = playingCards.length/3
    if @currentCardIndex % numCols == (numCols-1) and @currentCardIndex - (numCols-1) >= 0
      @currentCardIndex -= (numCols-1)
    else
      @currentCardIndex += 1
    end
  end

  # Created 09/12/2019 by Sharon Qiu
  # Edited 09/17/2019 by Sharon Qiu: Created conditions for movement upwards.
  def move_up playingCards

    numCols = playingCards.length/3
    if @currentCardIndex - numCols < 0
      @currentCardIndex += 2 * numCols
    else
      @currentCardIndex -= numCols
    end
  end

  # Created 09/12/2019 by Sharon Qiu
  # Edited 09/17/2019 by Sharon Qiu: Created conditions for movement downwards.
  def move_down playingCards

    numCols = playingCards.length/3
    if @currentCardIndex + numCols >= playingCards.length
      @currentCardIndex -= 2 * numCols
    else
      @currentCardIndex += numCols
    end
  end

  # Created 09/12/2019 by Sharon Qiu
  # Edited 09/17/2019 by Sharon Qiu: Created conditions for card selection. This updates the player instance variables and makes sure same cards not selected twice.
  def selection playingCards
    unless @chosenCardsIndexes.include? @currentCardIndex
      @chosenCardsIndexes.push @currentCardIndex
      @chosenCards.push playingCards[@currentCardIndex]
    else
      @chosenCardsIndexes.delete @currentCardIndex
      @chosenCards.delete playingCards[@currentCardIndex]
    end
  end

  # Created 09/18/2019 by Sharon Qiu: Clears chosen cards and chosen cards indices.
  def cleanSlate
    @chosenCards.clear
    @chosenCardsIndexes.clear
  end

  # Created 09/18/2019 by Sharon Qiu: Checks for a valid set and adjusts playing cards and chosen cards.
  # Edited 09/18/2019 by Sharon Qiu: Fixed mutator method to update playingCards. Also added/modifies setFound & hint_open and applied terse code.
  def chosenSetValidity! playingCards
    @setFound = isASet? @chosenCards
    @chosenCards.each {|card| playingCards.delete card} if @setFound
    cleanSlate #clears player picks
  end

  # Created 09/13/2019 by David Wing: Moved functionality to its own method.
  # Edited 09/15/2019 by Sri Ramya Dandu: Removed a parameter
  # Edited 09/19/2019 by Sharon Qiu: edited so it triggers hint_open.
  # Edited 09/20/2019 by Leah Gillespie: Update hintsUsed
  #
  # Given a valid set from the table, outputs two cards that make up a set
  # Returns array of two card objects that are the hint
  def get_hint cardsShowing
    valid_set = valid_table cardsShowing
    @score -= 0.5
    @hintsUsed += 1
    return [valid_set[0],valid_set[1]]
  end

end
