# File Created 09/10/2019 by Neel Mansukhani
# File Renamed 09/19/2019 by Neel Mansukhani to set_game.rb
# Edited 09/12/2019 by Neel Mansukhani
# Edited 09/15/2019 by Sharon Qiu
# Edited 09/15/2019 by Neel Mansukhani
# Edited 09/16/2019 by Neel Mansukhani
# Edited 09/17/2019 by Sharon Qiu
# Edited 09/17/2019 by Sri Ramya Dandu
# Edited 09/18/2019 by Neel Mansukhani
# Edited 09/18/2019 by Sri Ramya Dandu
# Edited 09/18/2019 by Sharon Qiu
# Edited 09/18/2019 by David Wing
# Edited 09/19/2019 by Sri Ramya Dandu
# Edited 09/19/2019 by Sharon Qiu
# Edited 09/19/2019 by David Wing
# Edited 09/19/2019 by Leah Gillespie
# Edited 09/20/2019 by Neel Mansukhani
# Edited 09/20/2019 by Sharon Qiu
# Edited 09/20/2019 by Leah Gillespie

# Edited 09/18/2019 by Neel Mansukhani: Change directory location of files.
require 'gosu'
require_relative 'Utilities/set_functions'
require_relative 'Objects/game_settings'
require_relative 'Objects/card'
require_relative 'Objects/deck'
require_relative 'Objects/timer'
require_relative 'Utilities/draws'
require_relative 'Objects/player'
require_relative 'Utilities/inputs'
require_relative 'Objects/computer_timer'

# Created 09/10/2019 by Neel Mansukhani
# Draw order for the screens
module ZOrder
  BACKGROUND, UI, BUTTON, TEXT, CARDS = *0..4
end

# Created 09/10/2019 by Neel Mansukhani
# Edited 09/15/2019 by Sharon Qiu: Added PLAYER_COLOR, where Gray is computer, red is player1, blue is player2.
# Edited 09/18/2019 by David Wing: added gameover menu options
module Options
  START_SCREEN = ["SOLO", "Computer", "2 Player"]
  LEVELS_SCREEN = ["Easy", "Medium", "Hard"]
  GAMEOVER_SCREEN = ["MENU", "EXIT"]
end

GAME_TITLE = "The Game of Set"

# Created 09/10/2019 by Neel Mansukhani
# This class extends Gosu's window class. When the show method is called,
# this program loops through input calls, draw, update on frequent intervals
# while the game is running.
class SetGame < Gosu::Window
  # Edited 09/18/2019 by Neel Mansukhani: Moved methods to modules.
  include Inputs, Draws, SetFunctions

  # Created 09/10/2019 by Neel Mansukhani
  # Edited 09/14/2019 by Sri Ramya Dandu: changed background and added buttons
  # Edited 09/17/2019 by Sharon Qiu: added in deck, playingCards, and playersCreated, as well as p1,p2,comp.
  # Edited 09/17/2019 by Sri Ramya Dandu: added computer timer
  # Edited 09/18/2019 by Sri Ramya Dandu: Added booleans to track when message is printed
  # Edited 09/19/2019 by Sharon Qiu: added hint variable in. Still needs GUI output.
  # Edited 09/20/2019 by Leah Gillespie: Adjusted window size and text/button spacing, added game timer
  def initialize
    @game_settings = GameSettings.new
    super 920, 480
    self.caption = GAME_TITLE
    @settings_hovered = Options::START_SCREEN[0]
    @title_font, @subtitle_font = Gosu::Font.new(50), Gosu::Font.new(20)
    @background_image = Gosu::Image.new("media/background1.jpg", :tileable => true)
    @blank_card = Gosu::Image.new("media/card.png", :tileable => true)
    @button_option = Gosu::Image.new("media/button.png", :tileable => true)
    @deck = Deck.new
    @playing_cards = Array.new
    @computer_signal = ComputerTimer.new
    @players_created, @mes, @false_mes, @true_mes, @trying_mes = false, false, false, false, false
    @hint = []
    #players
    @pressed, @p1, @p2 = nil, nil, nil
    @game_timer = Timers.new
  end

  # Created 09/10/2019 by Neel Mansukhani
  # Edited 09/15/2019 by Sharon Qiu: Edited game settings for gameplay selection, game settings for levels.
  # Edited 09/17/2019 by Sharon Qiu: Edited game screen checks. Split commands into p1 and p2.
  # Edited 09/17/2019 by Sri Ramya Dandu: Added computer functionality
  # Edited 09/19/2019 by David Wing: added gameover screen functionality
  # Edited 09/19/2019 by Sri Ramya Dandu: Added another computer message option
  # Edited 09/20/2019 by Sharon Qiu: passed in values for gameScreenInputs. Added in a reset for player set_found.
  # All inputs throughout the game are checked here.
  def update
    case @game_settings.current_screen
    when "start"
      start_screen_inputs
    when "levels"
      levels_screen_inputs
    when "game"
      if @deck.deck_count == 0 || valid_table(@playing_cards).length == 0
        @game_settings.current_screen = "gameover"
      end

      if @game_settings.is_cpu_player_enabled
        @mes = computer_move @p1 if @computer_signal.update?
        @true_mes = (@mes == 1) && @computer_signal.display_message?
        @false_mes = (@mes == 0) && @computer_signal.display_message?
        @trying_mes = (@mes == 2) && @computer_signal.display_message?
      end

      if @game_settings.p1_init
        game_screen_inputs @p1
        @p2.clean_slate if @game_settings.p2_init && @p1.set_found
        @p1.set_found = false #reset
      end

      if @game_settings.p2_init
        game_screen_inputs @p2
        @p1.clean_slate if @game_settings.p1_init && @p2.set_found
        @p2.set_found = false
      end

    when "gameover"
      game_over_screen_inputs
    end
  end

  # Created 09/16/2019 by Neel Mansukhani
  # Makes Gosu's button_down? function recieve one input per key press.
  def button_up? id
    button = button_down? id
    return false if @pressed != id && @pressed != nil
    if button && @pressed != id
      @pressed = id
      return true
    elsif !button
      @pressed = nil
    end
    return false
  end

  # Created 09/10/2019 by Neel Mansukhani
  # Edited 09/15/2019 by Sharon Qiu: Set up cards based on number of cards played.
  # Edited 09/16/2019 by Sharon Qiu: Draws rectangles based on selections and current position.
  # Edited 09/17/2019 by Sharon Qiu: Added check for player type.
  # Edited 09/18/2019 by Sri Ramya Dandu: Added output for computer to GUI
  # Edited 09/19/2019 by Leah Gillespie: Added player statistics and score
  # Edited 09/19/2019 by Sri Ramya Dandu: Added more computer output to GUI
  # Edited 09/19/2019 by Sharon Qiu: refined player movement for 1 & 2 player. Also added hint printout.
  # Edited 09/19/2019 by Leah Gillespie: Added game statistics
  # Edited 09/19/2019 by David Wing: Added check for game over
  # Edited 09/20/2019 by Neel Mansukhani: Made highlight for hints better
  # Edited 09/20/2019 by Leah Gillespie: Added game timer
  # All front end images and shapes are drawn here throughout the game.
  def draw
    @background_image.draw 0, 0, ZOrder::BACKGROUND
    case @game_settings.current_screen
    when "start"
      start_screen
    when "levels"
      levels_screen
    when "gameover"
      game_over_screen
    when "game"
      @deck.deal_cards! @playing_cards

      if @game_settings.is_cpu_player_enabled
        @subtitle_font.draw_text "Computer:", 645, 215, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK
        @subtitle_font.draw_text "Score : #{@computer_signal.score}", 645, 245, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK
      end

      # Computer messages
      if @true_mes
        @subtitle_font.draw_text "I found a set!", 645, 275, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK
        if @computer_signal.score > 3 && @computer_signal.score - @p1.score > 3
          @subtitle_font.draw_text "#{@computer_signal.mean_msg}", 645, 305, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK
        end
      end

      @subtitle_font.draw_text "Still trying!", 645, 275, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK if @trying_mes

      @subtitle_font.draw_text "Oops not a set!", 645, 275, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK if @false_mes

      # Creates players if need be.
      if !@players_created
        @p1 = Player.new 1 if @game_settings.p1_init
        @p2 = Player.new 2 if @game_settings.p2_init
        @players_created = true
      end

      Gosu.draw_rect 640,0,280,480,Gosu::Color::GRAY,ZOrder::UI

      @subtitle_font.draw_text "Player 1 Statistics:", 645, 0, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK
      if @p1.set_times.length > 0
      	@subtitle_font.draw_text "Fastest time to find a set: #{@p1.set_times.at 0}", 645, 30, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK
      	@subtitle_font.draw_text "Slowest time to find a set: #{@p1.set_times.at -1}", 645, 60, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK
      	@subtitle_font.draw_text "Average time to find a set: #{@p1.time_sum / @p1.set_times.length}", 645, 90, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK
      else
      	@subtitle_font.draw_text "No sets found yet", 645, 30, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK
      end
      @subtitle_font.draw_text "Hints used: #{@p1.hints_used}", 645, 120, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK if @game_settings.are_hints_enabled
      @subtitle_font.draw_text "Score: #{@p1.score}", 645, 150, ZOrder::TEXT,  1.0, 1.0, Gosu::Color::BLACK
      @subtitle_font.draw_text "Total Game Time: #{@game_timer.current}", 645, 490, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK
      
      if @game_settings.p2_init
        @subtitle_font.draw_text "Player 2 Statistics:", 645, 280, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK
      	if @p2.set_times.length > 0
      	  @subtitle_font.draw_text "Fastest time to find a set: #{@p2.set_times.at 0}", 645, 310, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK
      	  @subtitle_font.draw_text "Slowest time to find a set: #{@p2.set_times.at -1}", 645, 340, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK
      	  @subtitle_font.draw_text "Average time to find a set: #{@p2.time_sum / @p2.set_times.length}", 645, 370, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK
      	else
      	  @subtitle_font.draw_text "No sets found yet", 645, 310, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK
      	end
      	@subtitle_font.draw_text "Score: #{@p2.score}", 645, 430, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::BLACK
      end

      num_cols = @playing_cards.length / 3
      count, x_offset, y_offset, x_between, y_between = 0, 5, 35, 90, 135
      (0...3).each do |row|
        (0...num_cols).each do |col|
          @playing_cards[count].image.draw(x_offset + x_between*col, y_offset + y_between*row, ZOrder::CARDS, 0.15, 0.15)
          count += 1
        end
      end

      # Prints out hints
      @hint.each do |card_index|
        # initial card corner values.
        left_x ,right_x, top_y, bottom_y = 5, 85, 40, 160

        # Highlight for hints
        draw_rect left_x + x_between*(card_index % num_cols), top_y + y_between*(card_index / num_cols),80,10,Gosu::Color::BLACK,ZOrder::CARDS
        draw_rect left_x + x_between*(card_index % num_cols), top_y + y_between*(card_index / num_cols),10,130,Gosu::Color::BLACK,ZOrder::CARDS
        draw_rect left_x + x_between*(card_index % num_cols), bottom_y + y_between*(card_index / num_cols),80,10,Gosu::Color::BLACK,ZOrder::CARDS
        draw_rect right_x + x_between*(card_index % num_cols), top_y + y_between*(card_index / num_cols),10,130,Gosu::Color::BLACK,ZOrder::CARDS
      end

      #TO MOVE RECTANGLE:
      # X POSITION = @currentCardIndex % numCols
      # Y POSITION = @currentCardIndex / numCols
      if @game_settings.p1_init
        x_movement = x_offset + (x_between/2.4) + x_between*(@p1.current_card_index % num_cols)
        y_movement = y_offset + (y_between/2) + y_between*(@p1.current_card_index  / num_cols)

        # Draws current position
        draw_rect x_movement, y_movement, 20, 20, Gosu::Color::CYAN,ZOrder::CARDS

        # Draws current selected values
        @p1.chosen_cards_indexes.each {|index| draw_rect(x_offset + (x_between/2.4) + (x_between)*(index % num_cols), y_offset + (y_between/2) + y_between*(index  / num_cols), 20, 20, Gosu::Color::CYAN, ZOrder::CARDS)}
      end
      if @game_settings.p2_init
        x_movement = x_offset + (x_between/2.4) + x_between*(@p2.current_card_index % num_cols)
        y_movement = (y_between/2) + y_between*(@p2.current_card_index  / num_cols)

        # Draws current position
        draw_rect x_movement, y_movement, 20, 20, Gosu::Color::FUCHSIA, ZOrder::CARDS

        # Draws current selected values
        @p2.chosen_cards_indexes.each {|index| draw_rect(x_offset + (x_between/2.4) + (x_between)*(index % num_cols), (y_between/2) + y_between*(index  / num_cols), 20, 20, Gosu::Color::FUCHSIA, ZOrder::CARDS)}
      end
    end
  end
end

SetGame.new.show
