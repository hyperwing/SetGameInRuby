require 'gosu'
module ZOrder
  BACKGROUND, UI, BUTTON, TEXT, CARDS= *0..4
end
class StartScreen < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "The Game of Set"
    @title_font = Gosu::Font.new(50)
    @subtitle_font = Gosu::Font.new(20)
    @background_image = Gosu::Image.new("media/background.jpg", :tileable => true)
  end

  def update
  end

  def draw
    @background_image.draw(0, 0, ZOrder::BACKGROUND)
    @title_font.draw_text("The Game of Set", 140, 50, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    @subtitle_font.draw_text("Use W, A, S, D, and Spacebar to move/select.", 130, 110, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)

  end
end

StartScreen.new.show