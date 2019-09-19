# File Created 09/12/2019 by Neel Mansukhani
# Edited 09/17/2019 by Sharon Qiu: Added attributes to the accessor.
class GameSettings
  attr_accessor :currentScreen,:isTwoPlayerEnabled,:isCPUPlayerEnabled,:cpuDifficulty,:p1Init,:p2Init,:computerInit
  def initialize
    @currentScreen = "start"
    @areHintsEnabled = true
    @isTwoPlayerEnabled = false
    @isCPUPlayerEnabled = false
    @cpuDifficulty = "Easy"
    @isTimerEnabled = false
    @p1Init = false
    @p2Init = false
    @computerInit = false
  end

  # Created 09/18/2019 by Neel Mansukhani
  # Changes game mode and related variables, based on user selection.
  def changeGameMode(gameMode)
    if gameMode == "SOLO"
      @p1Init = true
      @currentScreen = "game"
      @areHintsEnabled = true
    elsif gameMode == "Computer"
      @isCPUPlayerEnabled = true
      @p1Init = true
      @computerInit = true
      @currentScreen = "levels"
      @areHintsEnabled = true
    else
      @isTwoPlayerEnabled = true
      @p1Init = true
      @p2Init = true
      @currentScreen = "game"
      @areHintsEnabled = false
    end
  end
end