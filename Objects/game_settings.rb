# File Created 09/12/2019 by Neel Mansukhani
# Edited 09/17/2019 by Sharon Qiu: Added attributes to the accessor.
# Edited 09/19/2019 by Sharon Qiu: Added access to areHintsEnabled
# Edited 09/19/2019 by Sri Ramya Dandu: Changed CPU Difficulty attribute

class GameSettings
  attr_accessor :current_screen, :is_two_player_enabled, :are_hints_enabled, :is_cpu_player_enabled, :cpu_difficulty, :p1_init, :p2_init, :computer_init
  def initialize
    @current_screen = "start"
    @are_hints_enabled, @is_two_player_enabled, @is_cpu_player_enabled, @is_timer_enabled, @p1_init, @p2_init, @computer_init = false, false, false, false, false, false, false
    @cpu_difficulty = 1
  end

  # Created 09/18/2019 by Neel Mansukhani
  # Changes game mode and related variables, based on user selection.
  def change_game_mode(game_mode)
    if game_mode == "SOLO"
      @p1_init = true
      @current_screen = "game"
      @are_hints_enabled = true
    elsif game_mode == "Computer"
      @is_cpu_player_enabled = true
      @p1_init = true
      @computer_init = true
      @current_screen = "levels"
      @are_hints_enabled = true
    elsif game_mode == "gameover"
      @is_cpu_player_enabled = false
      @p1_init = true
      @computer_init = false
      @current_screen = "gameover"
      @are_hints_enabled = false
    else
      @is_two_player_enabled = true
      @p1_init = true
      @p2_init = true
      @current_screen = "game"
      @are_hints_enabled = false
    end
  end
end