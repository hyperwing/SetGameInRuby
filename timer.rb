# File created 9/15 David Wing

=begin
 #TODO: Add Class Description
=end

# Created 09/12/2019 by Leah Gillespie
# TODO: Add documentation for each function
class AllTimers
    attr_reader :current

    # Created 09/12/2019 by Leah Gillespie
    def initialize
      @initial = Time.now
      @current = 0
    end

    # Created 09/12/2019 by Leah Gillespie
    def updateTime
      @current = Time.now - @initial
    end

    # Created 09/12/2019 by Leah Gillespie
    def reset
      @initial = Time.now
    end
  end