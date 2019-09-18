#File Created 09/17/2019 by Neel Mansukhani


# Created 09/17/2019 by Neel Mansukhani
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
end

# Created 09/17/2019 by Neel Mansukhani
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
  else
    #TODO: anything else?
  end
end

# Created 09/17/2019 by Neel Mansukhani
def gameScreenInputs(p1,p2)
  if button_up? Gosu::KB_A
    p1.move_left @playingCards
    puts "p1: #{p1.currentCardIndex}"
  elsif button_up? Gosu::KB_D
    p1.move_right @playingCards
    puts "p1: #{p1.currentCardIndex}"
  elsif button_up? Gosu::KB_W
    p1.move_up @playingCards
    puts "p1: #{p1.currentCardIndex}"
  elsif button_up? Gosu::KB_S
    p1.move_down @playingCards
    puts "p1: #{p1.currentCardIndex}"
  elsif button_up? Gosu::KB_SPACE
    p1.selection @playingCards

    if p1.chosenCardsIndexes.length == 3
      # TODO: In the future, implement check for score adjustments with hint usage
      if @deck.isASet?(p1.chosenCards)
        puts "Set found"
        @playingCards -= p1.chosenCards
        p2.chosenCards.clear #clears it so if selected cards were ones already chosen/found, it doesn't cause conflicts
        # TODO: Change score, make a trigger for updating the window
      else
        puts "Set not found"
        # TODO: Change score, make a trigger for updating the window
      end
      p1.chosenCards.clear
      p1.chosenCardsIndexes.clear
    end

    puts "p1: #{p1.currentCardIndex}"
  elsif button_up? Gosu::KB_H
    p1.hint
  end

  if button_up? Gosu::KB_LEFT
    p2.move_left @playingCards
    puts "p2: #{p2.currentCardIndex} "
  elsif button_up? Gosu::KB_RIGHT
    p2.move_right @playingCards
    puts "p2: #{p2.currentCardIndex} "
  elsif button_up? Gosu::KB_UP
    p2.move_up @playingCards
    puts "p2: #{p2.currentCardIndex} "
  elsif button_up? Gosu::KB_DOWN
    p2.move_down @playingCards
    puts "p2: #{p2.currentCardIndex} "
  elsif button_up? Gosu::KB_RETURN
    p2.selection @playingCards

    if p2.chosenCardsIndexes.length == 3
      # TODO: In the future, implement check for score adjustments with hint usage
      if @deck.isASet?(p2.chosenCards)
        puts "Set found"
        @playingCards -= p2.chosenCards
        p1.chosenCards.clear #clears it so if selected cards were ones already chosen/found, it doesn't cause conflicts
        # TODO: Change score, make a trigger for updating the window
      else
        puts "Set not found"
        # TODO: Change score, make a trigger for updating the window
      end
      p2.chosenCards.clear
      p2.chosenCardsIndexes.clear
    end
    puts "p2: #{p2.currentCardIndex} "
  end
end