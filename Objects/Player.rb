# File Created 09/17/2019 by Neel Mansukhani
# Edited 09/15/2019 by Sharon Qiu
# Edited 09/17/2019 by Sharon Qiu
# Edited 09/18/2019 by Sharon Qiu
# Edited 09/18/2019 by Leah Gillespie
# Edited 09/19/2019 by Sharon Qiu
# Edited 09/20/2019 by Leah Gillespie
# Edited 09/20/2019 by Sharon Qiu

# TODO: rename file

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
  # TODO: Refractor everything
  # Created 09/12/2019 by Sharon Qiu
  def initialize player_num

    @playerControls = @@p1Controls if player_num == 1
    @playerControls = @@p2Controls if player_num == 2
    @currentCardIndex, @timeSum, @hintsUsed, @score = 0, 0, 0, 0
    @chosenCards = Array.new
    @chosenCardsIndexes = Array.new
    @setTimer = AllTimers.new
    @setTimes = Array.new
    @setFound = false

  end

  # Created 09/12/2019 by Sharon Qiu
  # Edited 09/17/2019 by Sharon Qiu: Created conditions for movement leftwards.
  # Moves the player's cursor left.
  def move_left playing_cards
    num_cols = playing_cards.length / 3
    if @currentCardIndex % num_cols == 0 && @currentCardIndex < playing_cards.length
      @currentCardIndex += num_cols - 1
    else
      @currentCardIndex -= 1
    end
  end

  # Created 09/12/2019 by Sharon Qiu
  # Edited 09/17/2019 by Sharon Qiu: Created conditions for movement rightwards.
  # Edited 09/19/2019 by Sharon Qiu: Edited movement so that it accounted for number of columns.
  # Moves the player's cursor right.
  def move_right playing_cards
    num_cols = playing_cards.length / 3
    if @currentCardIndex % num_cols == num_cols - 1 && @currentCardIndex - num_cols - 1 >= 0
      @currentCardIndex -= num_cols - 1
    else
      @currentCardIndex += 1
    end
  end

  # Created 09/12/2019 by Sharon Qiu
  # Edited 09/17/2019 by Sharon Qiu: Created conditions for movement upwards.
  # Moves the player's cursor up.
  def move_up playing_cards
    num_cols = playing_cards.length / 3
    if @currentCardIndex - num_cols < 0
      @currentCardIndex += 2 * num_cols
    else
      @currentCardIndex -= num_cols
    end
  end

  # Created 09/12/2019 by Sharon Qiu
  # Edited 09/17/2019 by Sharon Qiu: Created conditions for movement downwards.
  # Moves the player's cursor down.
  def move_down playing_cards
    num_cols = playing_cards.length/3
    if @currentCardIndex + num_cols >= playing_cards.length
      @currentCardIndex -= 2 * num_cols
    else
      @currentCardIndex += num_cols
    end
  end

  # Created 09/12/2019 by Sharon Qiu
  # Edited 09/17/2019 by Sharon Qiu: Created conditions for card selection. This updates the player instance variables and makes sure same cards not selected twice.
  # Edited 09/20/2019 by Sharon Qiu: Added functionality to unselect.
  # Selects the card a player's cursor is on.
  def selection playing_cards
    unless @chosenCardsIndexes.include? @currentCardIndex
      @chosenCardsIndexes.push @currentCardIndex
      @chosenCards.push playing_cards[@currentCardIndex]
    else
      @chosenCardsIndexes.delete @currentCardIndex
      @chosenCards.delete playing_cards[@currentCardIndex]
    end
  end

  # Created 09/18/2019 by Sharon Qiu
  # Clears chosen cards and chosen cards indices.
  def cleanSlate
    @chosenCards.clear
    @chosenCardsIndexes.clear
  end

  # Created 09/18/2019 by Sharon Qiu
  # Edited 09/18/2019 by Sharon Qiu: Fixed mutator method to update playingCards. Also added/modifies setFound & hint_open and applied terse code.
  # Checks for a valid set and adjusts playing cards and chosen cards.
  def chosenSetValidity! playing_cards
    @setFound = isASet? @chosenCards
    @chosenCards.each {|card| playing_cards.delete card} if @setFound
    cleanSlate # Clears player picks
  end

  # Created 09/13/2019 by David Wing: Moved functionality to its own method.
  # Edited 09/15/2019 by Sri Ramya Dandu: Removed a parameter
  # Edited 09/19/2019 by Sharon Qiu: edited so it triggers hint_open.
  # Edited 09/20/2019 by Leah Gillespie: Update hintsUsed
  # Given a valid set from the table, outputs two cards that make up a set
  # Returns array of two card objects that are the hint
  def get_hint cards_showing
    valid_set = valid_table cards_showing
    @score -= 0.5
    @hintsUsed += 1
    [valid_set[0],valid_set[1]]
  end

end
