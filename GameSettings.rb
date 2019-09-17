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
  def changeGameMode(gameMode)
    # TODO: do this
  end
end