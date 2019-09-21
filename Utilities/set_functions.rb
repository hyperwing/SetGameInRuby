# File created 09/04/2019 by Sri Ramya Dandu
# File renamed 09/18/2019 by Neel Mansukhani to set_functions.rb
# Edited 09/05/2019 by Leah Gillespie
# Edited 09/06/2019 David Wing
# Edited 09/06/2019 by Neel Mansukhani
# Edited 09/07/2019 by Sharon Qiu
# Edited 09/07/2019 by Neel Mansukhani
# Edited 09/07/2019 by Sri Ramya Dandu
# Edited 09/08/2019 by Sharon Qiu
# Edited 09/08/2019 by Neel Mansukhani
# Edited 09/09/2019 by David Wing
# Edited 09/09/2019 by Sharon Qiu
# Edited 09/09/2019 by David Wing
# Edited 09/09/2019 by Sri Ramya Dandu
# Edited 09/10/2019 by Sri Ramya Dandu
# Edited 09/12/2019 by Leah Gillespie
# Edited 09/12/2019 by David Wing
# Edited 09/14/2019 by Neel Mansukhani
# Edited 09/15/2019 by Sri Ramya Dandu
# Edited 09/15/2019 by David Wing
# Edited 09/16/2019 by Sri Ramya Dandu
# Edited 09/18/2019 by Neel Mansukhani

# Created 09/04/2019 by Sri Ramya Dandu
# Edited 09/18/2019 by Neel Mansukhani: Moved functions to module
module SetFunctions
  # Created 09/04/2019 by Sri Ramya Dandu
  # Edited 09/07/2019 by Sri Ramya Dandu: Optimized the checking method - made function concise
  # Checks if the 3 cards are a valid set or not. To be a valid set, all 3 cards must either have the same
  # attribute or all different attributes for each of the following attributes: number, color,shape,shade.
  # @param card1, card2, card3 to evaluate whether they form a set or not
  # @returns true if cards form a valid set, false otherwise
  # @updates $score
  def is_a_set?(cards)
    # The sum when adding one number 3 times or adding 3 consecutive numbers is divisible by 3.
    # This represents having all the same attribute or all different attributes.
    # Adding any other 3 number combo of 1,2,3 will result in a value not divisible by 3, failing to be a set.
    (cards[0].number + cards[1].number + cards[2].number) % 3 == 0 &&
        (cards[0].color + cards[1].color + cards[2].color) % 3 == 0 &&
        (cards[0].shape + cards[1].shape + cards[2].shape) % 3 == 0 &&
        (cards[0].shade + cards[1].shade + cards[2].shade) % 3 == 0
  end

  # Created 09/06/2019 by David Wing
  # Edited 09/07/2019 by David Wing
  # Edited 09/08/2019 by David Wing
  # Edited 09/09/2019 by Sri Ramya Dandu: changed cardsShowing to a global variable
  # Edited 09/12/2019 by David Wing: Optimized table searching
  # Edited 09/16/2019 by Sri Ramya Dandu: replaced for loops with ruby convention

  # Given an Array of the displayed cards, checks if there is a set
  # Returns an empty Array if there is not a set. If there is  set, it returns
  # an array holding the 3 cards that form the set
  def valid_table(cards_showing)

    # make hash of all table cards
    # id is the key, location is the value
    table_hash =  Hash.new
    return [] if cards_showing.length < 1

    (0...cards_showing.length).each {|i| table_hash[cards_showing[i].id] = i}

    (0...cards_showing.length).each do |card1|
      (1...cards_showing.length).each do |card2|
        if card1 == card2 #skip if same card
          next
        end

        # Find attributes of the last card needed
        # Using the attributes of any two cards, you can determine what the final card would be that would make a set
        # This finds the attributes of that last card, which is later used to see if that card is available
        card_to_find = 27 * ((6- cards_showing[card1].number - cards_showing[card2].number) % 3)
        card_to_find += 9 * ((6- cards_showing[card1].color - cards_showing[card2].color) %3)
        card_to_find += 3 * ((6- cards_showing[card1].shape - cards_showing[card2].shape) %3)
        card_to_find += (6-cards_showing[card1].shade - cards_showing[card2].shade) %3

        # cardToFind is now the card ID for the last card
        return [card1, card2, table_hash[card_to_find]] if table_hash.include? card_to_find

      end
    end

    return []
  end
end
