#File Created 09/12/2019 by Neel Mansukhani
class GameSettings
  attr_accessor :currentScreen
  def initialize
    @currentScreen = "start"
    @areHintsEnabled = true
    @isTwoPlayerEnabled = false
    @isCPUPlayerEnabled = false
    @cpuDifficulty = "Easy"
    @isTimerEnabled = false
  end
  def changeGameMode(gameMode)
    # TODO: do this
  end
end