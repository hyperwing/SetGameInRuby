# Created 09/12/2019 by Sharon Qiu
# Mapping player movement
require 'gosu'
module ZOrder
  BACKGROUND, UI, BUTTON, TEXT, CARDS= *0..4
end

$playerIdentity = new.Array #to map image/highlight for specific player to identify them.

# Created 09/12/2019 by Sharon Qiu
# Skeleton code for player movement and overall player data.
class Player

  attr_reader :score, :highlight, :currentCard

  def initialize playerStart
    @highlight = Gosu::Image.new($playerIdentity[playerNumber-1]) #TODO: Add image/box highlight for player
    @currentCard = None #TODO:Figure out positioning
    @score = 0
  end

  # Created 09/12/2019 by Sharon Qiu
  # Updates/keeps track of player score
  def scoreUpdate set, hint_used
    setFound = isASet? set
    return "#{}" if !setFound #TODO: Add to codeblock something to return if invalid set
    if hint_used && setFound
      @score += 0.5
    elsif setFound
      @score += 1
    end
  end


  def move_left
    # Fill in when we know set up of cards
    # Offsets depending on card positions
  end

  def move_right
    # Fill in when we know set up of cards
    # Offsets depending on card positions
  end

  def move_up
    # Fill in when we know set up of cards
    # Offsets depending on card positions
  end

  def move_down
    # Fill in when we know set up of cards
    # Offsets depending on card positions
  end

  def select chosenCards
    # chosenCards is selected cards
    # @currentSelected = position
    # chosenCards.push(@currentSelected)

    # Fill in when we know set up of cards
    # will probably have to highlight cards, kept track of chosen cards by array
  end
end

# Created 09/12/2019 by Sharon Qiu
# Gameplay window and checks for keyboard input.
class Gameplay < Gosu::Window
  def initialize player
    @Player = player
    super 640, 480
    @background_image = Gosu::Image.new("media/background.jpg", :tileable => true)
  end

  #Array playerKeys might be dependent on player
  # Not implemented right now
  # if we were to implement:
  # index:
  # 0 = left
  # 1 = right
  # 2 = up
  # 3 = down
  # 4 = select/enter
  def update playerKeys
    if Gosu.button_down? Gosu::KB_LEFT or Gosu.button_down? Gosu::KB_A
      @Player.move_left
    elsif Gosu.button_down? Gosu::KB_RIGHT or Gosu.button_down? Gosu::KB_D
      @Player.move_right
    elsif Gosu.button_down? Gosu::KB_UP or Gosu.button_down? Gosu::KB_W
      @Player.move_up
    elsif Gosu.button_down? Gosu::KB_DOWN or Gosu.button_down? Gosu::KB_S
      @Player.move_down
    elsif Gosu.button_down? Gosu::KB_SPACE or Gosu.button_down? Gosu::KB_RETURN
      @Player.select
    end

  end

  def draw
    @background_image.draw(0, 0, ZOrder::BACKGROUND)
    @subtitle_font.draw_text("Use W, A, S, D, and Spacebar to move/select.", 130, 110, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)

  end
end