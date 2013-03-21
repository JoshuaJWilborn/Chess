require_relative 'player.rb'
require_relative 'board.rb'

class Game
  def initialize
    @players = []
    @board   = Board.new
    start
    play
  end

  def start
    puts "Welcome to Chess!"
    puts "What is the name of Player 1? (white)"
    @players << Player.new(gets.chomp, :w)
    puts "What is the name of Player 2? (black)"
    @players << Player.new(gets.chomp, :b)
  end

  def play
    turn = 0
    # loop throught the board
    # display
    # prompt user
    # check color and if a piece exists
    # look to see if the king is in check or chechmate

    until @board.check_mate?(:w) || @board.check_mate?(:b)
      @board.display_board
      if @board.check?(@players[turn].color)
        puts "You are in check"
      end

      move = @players[turn].get_move
      if @board.get_square(move[0]).color != @players[turn].color
        puts "You cannot move an opponents piece! Try again."
        next
      end

      unless @board.valid_move?(move[0],move[1])
        puts "That is an invalid move! Try again."
        next
      end

      @board.make_move(move[0],move[1])
      turn = turn == 0 ? 1 : 0
    end

    if @board.check_mate?(:w)
      puts "Black Player 2, #{@player2.name} wins!"
    else
      puts "White Player 1, #{@player1.name} wins!"
    end
  end

end