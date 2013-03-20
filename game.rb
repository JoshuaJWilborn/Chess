require_relative 'player.rb'
require_relative 'board.rb'

class Game
  def initialize(Player1, Player2)
    @player1 = player1
    @player2 = player2
    @board = Board.new
  end

  def play
    # loop throught the board
    # display
    # prompt user
    # check color and if a piece exists
    # look to see if the king is in check or chechmate

    until @board.check_mate?
      @board.display_board

    end
  end

end