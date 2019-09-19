# File Created 09/17/2019 by Neel Mansukhani

# Created 09/12/2019 by Sharon Qiu: Skeleton code for player movement only within the game.
# Edited 09/15/2019 by Sharon Qiu: merged in player class into StartScreen file.
# Edited 09/17/2019 by Sharon Qiu: Edited all player movement functions.
# Edited 09/18/2019 by Sharon Qiu: Introduced parallel mapping keys.
# Edited 09/18/2019 by Leah Gillespie: Added player stats and score as instance variables
# Edited 09/18/2019 by Sharon Qiu: Included setFunctions module. Also moved get_hint into player class. Also created 2 new functions, chosen set validity and clean slate.
class Player

  include SetFunctions
  attr_accessor :currentCardIndex, :chosenCards, :chosenCardsIndexes, :playerControls, :playerMovement, :setTimer, :setTimes, :hintsUsed, :score, :hint_open, :timeSum

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
    @hint_open = false
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
    @chosenCardsIndexes.push @currentCardIndex if !(@chosenCardsIndexes.include? @currentCardIndex)
    @chosenCards.push playingCards[@currentCardIndex] if !(@chosenCards.include? playingCards[@currentCardIndex])
  end

  # Created 09/18/2019 by Sharon Qiu: Clears chosen cards and chosen cards indices.
  def cleanSlate
    @chosenCards.clear
    @chosenCardsIndexes.clear
  end

  # Created 09/18/2019 by Sharon Qiu: Checks for a valid set and adjusts playing cards and chosen cards.
  def chosenSetValidity playingCards
    valid = isASet? @chosenCards
    playingCards -= @chosenCards if valid
    cleanSlate
    valid
  end

  # Created 09/13/2019 by David Wing: Moved functionality to its own method.
  # Edited 09/15/2019 by Sri Ramya Dandu: Removed a parameter
  # Edited 09/19/2019 by Sharon Qiu: edited so it triggers hint_open.
  #
  # Given a valid set from the table, outputs two cards that make up a set
  # Returns array of two card objects that are the hint
  def get_hint cardsShowing
    valid_set = valid_table cardsShowing
    puts("look for a pair with these cards: ")
    puts("card " + cardsShowing[valid_set[0]].id.to_s + " and card " + cardsShowing[valid_set[1]].id.to_s)
    # TODO: Remove before submitting.
    # puts("card 3:" + cardsShowing[valid_set[2]].id.to_s) #DEBUG message

    @hint_open = true
    @score -= 0.5

    return [cardsShowing[valid_set[0]], cardsShowing[valid_set[1]]]

  end
end
