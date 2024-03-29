# File Created 09/15/2019 by David Wing
# Edited 09/16/2019 by Sri Ramya Dandu
# Edited 09/17/2019 by Sharon Qiu
# Defines the methods and structures for a deck of cards

class Deck

    include SetFunctions
    # Cards is an array of Card Objects in the deck
    # Count is how many cards are in the deck
    attr_accessor :cards, :deck_count

    # Created 09/15/2019 by David Wing
    # Creates a new instance of Card with the given attributes
    def initialize
        @cards = create_deck
        @deck_count = 81
    end

    # Created 09/05/2019 by Leah Gillespie
    # Edited 09/06/2019 by Neel Mansukhani: Moved code to function.
    # Edited 09/09/2019 by Sri Ramya Dandu: Changed deck to a global variable.
    # Edited 09/12/2019 by Leah Gillespie: Made sure to use terse code.
    # Edited 09/12/2019 by David Wing: Added id to be initialized.
    # Edited 09/14/2019 by Neel Mansukhani: Made deck a local variable.
    # Edited 09/15/2019 by David Wing: Deck is now object, cards is new structure
    # Edited 09/16/2019 by Sri Ramya Dandu: Replaced for loops with .each
    # Creates an array to be the deck and initializes 81 unique cards into it
    def create_deck
        deck = Array.new
        id = 0
        (0..2).each do |number|
            (0..2).each do |color|
                (0..2).each do |shape|
                    (0..2).each do |shade|
                        deck.push Card.new(id, number,color,shape,shade)
                        id += 1
                    end
                end
            end
        end
        deck
    end
    
    # Created 09/06/2019 by Neel Mansukhani
    # Edited 09/07/2019 by Sharon Qiu: Added in playingCards parameter and boolean value. Method now updates the showing cards.
    # Edited 09/08/2019 by Sharon Qiu: Added in checks for situations to deal cards. Removed boolean value.
    # Edited 09/09/2019 by Sri Ramya Dandu: changed deck and cardsShowing to a global variable
    # Edited 9/09/2019 by David Wing: changed to conform to deck object & added deckCount updates
    # Edited 09/15/2019 by Sri Ramya Dandu: changed arrays to local variables
    # Edited 09/16/2019 by Sri Ramya Dandu: changed for loops .times  do
    # Updates the passed in array of playingCards to a playable status for the player.
    # Does nothing if deck of unplayed cards is empty.
    # @updates cardsShowing
    def deal_cards!(cards_showing)
        return if @cards.length == 0
    
        #initializing deck.
        if cards_showing.length == 0
            12.times do
                card = @cards.delete_at(rand(cards.length))
                cards_showing.push(card)
                self.deck_count-=1
            end
        end
    
        if valid_table(cards_showing).length == 0
            #continually adds cards until there is a set or there are no more cards.
            while valid_table(cards_showing).length == 0 && cards.length > 0
                3.times do
                    card = @cards.delete_at rand cards.length
                    cards_showing.push card
                    self.deck_count -= 1
                end
            end
        elsif cards_showing.length < 12
            # Adds cards if there is a set but less than 12 playing cards.
            3.times do
                card = @cards.delete_at rand cards.length
                cards_showing.push card
                self.deck_count -= 1
            end
        end
    end
end