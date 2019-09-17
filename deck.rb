# Created 09/15/2019 by David Wing
# Defines the methods and structures for a deck of cards
# Edited 09/17/2019 by Sharon Qiu

require_relative 'Set'
require_relative 'card'

class Deck
    # cards is an array of Card Objects in the deck
    # count is how many cards are in the deck
    attr_accessor :cards, :deckCount

    # Creates a new instance of Card with the given attributes
    def initialize()
        @cards = createDeck
        @deckCount = 81
    end


    # Created 09/05/2019 by Leah Gillespie
    # Edited 09/06/2019 by Neel Mansukhani: Moved code to function.
    # Edited 09/09/2019 by Sri Ramya Dandu: Changed deck to a global variable.
    # Edited 09/12/2019 by Leah Gillespie: Made sure to use terse code.
    # Edited 09/12/2019 by David Wing: Added id to be initialized.
    # Edited 09/14/2019 by Neel Mansukhani: Made deck a local variable.
    # Edited 09/15/2019 by David Wing: Deck is now object, cards is new structure
    # Edited 09/17/2019 by Sharon Qiu: Pulled isASet method and placed in class Deck.

    # Creates an array to be the deck and initializes 81 unique cards into it
    def createDeck
        deck = Array.new
        id = 0
        for number in 0..2
            for color in 0..2
                for shape in 0..2
                    for shade in 0..2
                        deck.push Card.new(id, number,color,shape,shade)
                        id += 1
                    end
                end
            end
        end
        return deck
    end

    
    # Created 09/06/2019 by Neel Mansukhani
    # Edited 09/07/2019 by Sharon Qiu: Added in playingCards parameter and boolean value. Method now updates the showing cards.
    # Edited 09/08/2019 by Sharon Qiu: Added in checks for situations to deal cards. Removed boolean value.
    # Edited 09/09/2019 by Sri Ramya Dandu: changed deck and cardsShowing to a global variable
    # Edited 9/09/2019 by David Wing: changed to conform to deck object & added deckCount updates

    # Updates the passed in array of playingCards to a playable status for the player.
    # Does nothing if deck of unplayed cards is empty.
    # @updates cardsShowing
    def dealCards! cardsShowing
        return if cards.length == 0
    
        #initializing deck.
        if cardsShowing.length == 0
            for count in 0...12
                card = cards.delete_at(rand(cards.length))
                cardsShowing.push(card)
                self.deckCount-=1
            end
            return
        end
    
        if valid_table(cardsShowing).length == 0
            #continually adds cards until there is a set or there are no more cards.
            while (valid_table(cardsShowing).length == 0) && cards.length > 0
                #print("\n Empty: #{(valid_table(playingCards)).length == 0} \n")
                for count in 0...3
                    card = cards.delete_at(rand(cards.length))
                    cardsShowing.push(card)
                    self.deckCount-=1
                end
            end
        elsif cardsShowing.length < 12
            # Adds cards if there is a set but less than 12 playing cards.
            for count in 0...3
                card = cards.delete_at(rand(cards.length))
                cardsShowing.push(card)
                self.deckCount-=1
            end
        end
    end

    # Created 09/04/2019 by Sri Ramya Dandu
    # Edited 09/07/2019 by Sri Ramya Dandu: Optimized the checking method - made function concise
    #   Checks if the 3 cards are a valid set or not. To be a valid set, all 3 cards must either have the same
    #   attribute or all different attributes for each of the following attributes: number, color,shape,shade.
    #   @param card1, card2, card3 to evaluate whether they form a set or not
    #   @returns true if cards form a valid set, false otherwise
    #   @updates $score
    def isASet?(cards)
        # The sum when adding one number 3 times or adding 3 consecutive numbers is divisible by 3.
        # This represents having all the same attribute or all different attributes.
        # Adding any other 3 number combo of 1,2,3 will result in a value not divisible by 3, failing to be a set.
        (cards[0].number + cards[1].number + cards[2].number) % 3 == 0 &&
            (cards[0].color + cards[1].color + cards[2].color) % 3 == 0 &&
            (cards[0].shape + cards[1].shape + cards[2].shape) % 3 == 0 &&
            (cards[0].shade + cards[1].shade + cards[2].shade) % 3 == 0
    end
end