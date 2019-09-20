# File Created 09/15/2019 by David Wing

# Keeps track of time for statistics.

# Created 09/12/2019 by Leah Gillespie
# TODO: refractor AllTimers to Timers
class AllTimers
    attr_reader :current

    # Created 09/12/2019 by Leah Gillespie
    def initialize
      @initial = Time.now
      @current = 0
    end

    # Created 09/12/2019 by Leah Gillespie
    # Edited 09/19/2019 by Leah Gillespie: rounds current time to two decimal places
    # updates @current to reflect the difference between when the timer started and the time the method is called
    # TODO: Refractor updateTime to update_time
    def updateTime
      @current = (Time.now - @initial).round 2
    end

    # Created 09/12/2019 by Leah Gillespie
    # restarts the timer at the time the method is called
    def reset
      @initial = Time.now
    end
  end
