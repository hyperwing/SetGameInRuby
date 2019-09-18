# File created 09/17/2019 by Sri Ramya Dandu
# Edited 09/18/2019 by Sri Ramya Dandu

require_relative 'card'
require_relative 'deck'

# Created 09/17/2019 by Sri Ramya Dandu
# Edited 09/18/2019 by Sri Ramya Dandu: Added function display_message?
#provides a signal to determine whether the computer gets a turn or not
class ComputerTimer

  attr_writer :level

  # Created 09/17/2019 by Sri Ramya Dandu
  # Initializes the time
  def initialize(level)
    @start_time = Time.now
    @last_time_value = 0
    @level_num = level
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
  def play?
    if seconds%@level_num == 0 && seconds != @last_time_value
      @last_time_value = seconds
      true
    else
      false
    end
  end

  # Created 09/18/2019 by Sri Ramya Dandu
  # Signals true to keep the computer message up for 6 seconds after computer takes a turn, false otherwise
  def display_message?
    if play? || (seconds-@last_time_value) < 6 && @last_time_value > @level_num
      true
    else
      false
    end
  end
  end