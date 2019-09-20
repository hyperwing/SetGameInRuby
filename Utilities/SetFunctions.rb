# File created 09/04/2019 by Sri Ramya Dandu
# File renamed 09/18/2019 by Neel Mansukhani to SetFunctions.rb
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
# TODO: Add file description for every file.
# TODO: Multi line comments for function descriptions.

# Edited 09/18/2019 by Neel Mansukhani: Moved functions to module
module SetFunctions
  # Created 09/04/2019 by Sri Ramya Dandu
  # Edited 09/07/2019 by Sri Ramya Dandu: Optimized the checking method - made function concise
  #   Checks if the 3 cards are a valid set or not. To be a valid set, all 3 cards must either have the same
  #   attribute or all different attributes for each of the following attributes: number, color,shape,shade.
  #   @param card1, card2, card3 to evaluate whether they form a set or not
  #   @returns true if cards form a valid set, false otherwise
  #   @updates $score
  def isASet? cards
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

  #  Given an Array of the displayed cards, checks if there is a set
  #  Returns an empty Array if there is not a set. If there is  set, it returns
  #  an array holding the 3 cards that form the set
  def valid_table cardsShowing 

    # make hash of all table cards
    # id is the key, location is the value
    tableHash =  Hash.new
    if cardsShowing.length < 1
      return []
    end

    (0...cardsShowing.length).each {|i| tableHash[cardsShowing[i].id] = i}

    (0...cardsShowing.length).each do |card1|
      (1...cardsShowing.length).each do |card2|
        if card1 == card2 #skip if same card
          next
        end

        # Find attributes of the last card needed
        # TODO: Make 1 line?
        # TODO: Explain this shit
        cardToFind = 27 * ((6- cardsShowing[card1].number - cardsShowing[card2].number) % 3)
        cardToFind += 9 * ((6- cardsShowing[card1].color - cardsShowing[card2].color) %3)
        cardToFind += 3 * ((6- cardsShowing[card1].shape - cardsShowing[card2].shape) %3)
        cardToFind += (6-cardsShowing[card1].shade - cardsShowing[card2].shade) %3

        # cardToFind is now the card ID for the last card
        if tableHash.include?cardToFind
          return [card1, card2, tableHash[cardToFind]]
        end

      end
    end

    return []
  end
end