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

  def get_square(coords)
    @board[coords[0]][coords[1]]
  end

  def set_square(coords, value)
    @board[coords[0]][coords[1]] = value
  end

  def make_move(start, finish, current_color)
    if valid_move?(start, finish, current_color)
      piece = get_square(start)
      set_square(finish, pieces)
      set_square(start, nil)
    else
      nil # is nil a good return? 
    end
  end

  def valid_move?(start, finish, current_color)
    start_square = get_square(start)
    finish_square = get_square(finish)
    if start_square.nil?
      false
    elsif color_conflict(start_square, finish_square)
      false # cannot move ontop of your own piece 
    elsif start_square.all_moves(start)
      
    end 
    # is it in the range of possible moves
    # is there something blocking it
  end

  def color_conflic?(square1, square2)
    if square1.respond_to(:color) && square2.respond_to(:color) 
      start_square.color != finish_square.color ? false : true
    else
      false
    end
  end


  def check?
    
  end

  def check_mate?
    
  end


end




