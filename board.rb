require_relative 'pieces.rb'

class Board
  def initialize
    @board = Array.new(8) { Array.new(8) }
    new_game
  end

  def new_game
    @board[0] = [
                 Rook.new(:b),
                 Knight.new(:b),
                 Bishop.new(:b),
                 Queen.new(:b),
                 King.new(:b),
                 Bishop.new(:b),
                 Knight.new(:b),
                 Rook.new(:b)
               ]
    @board[1] = Array.new(8, Pawn.new(:b))
    @board[6] = Array.new(8, Pawn.new(:w))
    @board[7] = [
                 Rook.new(:w),
                 Knight.new(:w),
                 Bishop.new(:w),
                 Queen.new(:w),
                 King.new(:w),
                 Bishop.new(:w),
                 Knight.new(:w),
                 Rook.new(:w)
               ]
  end

  def display_board
    (0..7).each do |row|
      (0..7).each do |col|
        if @board[row][col].respond_to?(:name)
          print " #{@board[row][col].name} "
        else
          print " _ "
        end
      end 
      print "\n" 
    end
  end

end