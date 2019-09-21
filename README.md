# Project 2
### Game of Set
This project required the team to build the game of Set (https://en.wikipedia.org/wiki/Set_(card_game)). The implemented game contains the basic functionality of Set, in addition to the following extra features: hints, timer, statistics, computer player, 2 player, and a GUI implementation. 



### Roles
* Overall Project Manager: Sharon Qiu
* Coding Manager: Sri Ramya Dandu
* Testing Manager: Leah Gillespie
* Documentation Manager: David Wing 

### Contributions
Checkpoint one:
* Sharon Qiu - Implemented checks for dealing cards and ending the game.
* Sri Ramya Dandu - Checking tuples chosen by the player for set validity.
* Leah Gillespie - Creating the overall deck.
* David Wing - Checking if there is a set in each set of played cards.
* Neel Mansukhani - All I/O and dealling cards.

Extra Implementations:
* Sharon Qiu - Multiplayer and player movement, hint implementation(Gameplay display), player button highlight on other screens(pair programmed).
* Sri Ramya Dandu - Computer player, levels, and its interaction/display on GUI
* Leah Gillespie - Stats and Timer and displaying it in GUI(Gameplay Display)
* David Wing - Hint implementation(backend functionality), and gameover screen in GUI
* Neel Mansukhani - Displaying all cards in game screen, button mapping for start and level screen, player button highlight on other screens(pair programmed).

Any minor edits to functionalities were implemented by whichever group member saw a need for said implementations. View documentation to see specifics.
### How to run the project

Step 1. Install Gosu using the instructions below.

  Gosu Requirements: 
  
  a. Update/ upgrade exisiting packages with the following call
    sudo apt-get update
    sudo apt-get upgrade

  b. Visit the gosu installation page and follow instructions: https://github.com/gosu/gosu/wiki/Getting-Started-on-Linux
     *Copy and pasting might result in errors 

  * If errors occur while install gosu and state that certain packages are not found then use the following call to identify  the missing library and then install it

    sudo apt-cache search [package]
    sugo apt-get install package-dev
    

Step 2. Pull the project from git. In the selected directory, run the following command line: bundler exec ruby set_game.rb 
