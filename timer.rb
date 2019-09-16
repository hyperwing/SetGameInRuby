# File created 9/15 David Wing

# Created 09/12/2019 by Leah Gillespie
# TODO: Add documentation for the class and each function
class AllTimers
    attr_reader :current
    def initialize
      @initial = Time.now
      @current = 0
    end
    def updateTime
      @current = Time.now - @initial
    end
    def reset
      @initial = Time.now
    end
  end