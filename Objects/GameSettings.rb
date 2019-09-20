# File Created 09/12/2019 by Neel Mansukhani
# Edited 09/17/2019 by Sharon Qiu: Added attributes to the accessor.
# Edited 09/19/2019 by Sharon Qiu: Added access to areHintsEnabled
# Edited 09/19/2019 by Sri Ramya Dandu: Changed CPU Difficulty attribute
# TODO: Refractor Everything
# TODO: Rename file
class GameSettings
  attr_accessor :currentScreen,:isTwoPlayerEnabled, :areHintsEnabled, :isCPUPlayerEnabled,:cpuDifficulty,:p1Init,:p2Init,:computerInit
  def initialize
    # TODO: refractor p2init with istwoplayerenabled
    @currentScreen = "start"
    @areHintsEnabled, @isTwoPlayerEnabled, @isCPUPlayerEnabled, @isTimerEnabled, @p1Init, @p2Init, @computerInit = false, false, false, false, false, false, false
    @cpuDifficulty = 1
  end

  # Created 09/18/2019 by Neel Mansukhani
  # Changes game mode and related variables, based on user selection.
  def changeGameMode(game_mode)
    if game_mode == "SOLO"
      @p1Init = true
      @currentScreen = "game"
      @areHintsEnabled = true
    elsif game_mode == "Computer"
      @isCPUPlayerEnabled = true
      @p1Init = true
      @computerInit = true
      @currentScreen = "levels"
      @areHintsEnabled = true
    elsif game_mode == "gameover"
      @isCPUPlayerEnabled = false
      @p1Init = true
      @computerInit = false
      @currentScreen = "gameover"
      @areHintsEnabled = false
    else
      @isTwoPlayerEnabled = true
      @p1Init = true
      @p2Init = true
      @currentScreen = "game"
      @areHintsEnabled = false
    end
  end
end