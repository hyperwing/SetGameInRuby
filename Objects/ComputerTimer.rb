# File created 09/17/2019 by Sri Ramya Dandu
# Edited 09/18/2019 by Sri Ramya Dandu
# Edited 09/19/2019 by Sri Ramya Dandu

# Created 09/17/2019 by Sri Ramya Dandu
# Edited 09/18/2019 by Sri Ramya Dandu: Added function display_message?
# Provides a signal to determine whether the computer gets a turn or not
class ComputerTimer

  attr_writer :level
  attr_accessor :score, :mean_msg


  # Created 09/17/2019 by Sri Ramya Dandu
  # Edited 09/19/2019 by Sri Ramya Dandu: Added messages
  # Initializes the time to signal for computer's turns and score
  def initialize()
    @start_time = Time.now
    @last_time_value = 0
    @level_num = rand(20...35)
    @score = 0
    @insults = ["Oh man, you SUCK", "GIT GUD", "Pick it up", "Woohoo I'm winning", "I'm the BEST", "You call this a game?", "B U R N", "Git better", "Git checkout skills", "You can't compete"]
    @mean_msg = @insults[rand(0...@insults.length)]
  end

  # Created 09/17/2019 by Sri Ramya Dandu
  # updates the signal for the computer
  def update
    play?
  end

  # Created 09/17/2019 by Sri Ramya Dandu
  # obtains numeric value for current seconds
  def seconds
    (Time.now - @start_time).to_i
  end

  # Created 09/17/2019 by Sri Ramya Dandu
  # Determines if it is the computers turn to play after x seconds
  # Edited 09/19/2019 by Sri Ramya Dandu: Randomly picks the mean message
  def play?
    if seconds%@level_num == 0 && seconds != @last_time_value
      @last_time_value = seconds
      true
      @mean_msg = @insults[rand(0...@insults.length)]
    else
      false
    end
  end

  # Created 09/18/2019 by Sri Ramya Dandu
  # Signals true to keep the computer message up for 6 seconds after computer takes a turn, false otherwise
  def display_message?
    if play? || (seconds-@last_time_value) < 6 && @last_time_value >= @level_num
      true
    else
      false
    end
  end
  end