# Created 9/05/2019 by David Wing
# Defines the methods and structures for a deck of cards

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
    # @updates playingCards
    def dealCards(cardsShowing)
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

end