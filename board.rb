require_relative 'pieces.rb'
require 'colorize'

class Board
  attr_accessor :board
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
    print "  a  b  c  d  e  f  g  h\n"
    alt_colors = [:white, :blue]
    color_map = { :w => :red, :b => :black}
    alt_index = 1
    (0..7).each do |row|
      print (8 - row)
      (0..7).each do |col|
        if @board[row][col].respond_to?(:name)
          print " #{@board[row][col].name} ".colorize(:background => alt_colors[alt_index], :color => color_map[@board[row][col].color])

        else
          print "   ".colorize(:background => alt_colors[alt_index])
        end
        alt_index = alt_index == 1 ? 0 : 1
      end
      print (8 - row)
      print "\n"
      alt_index = alt_index == 1 ? 0 : 1
    end
    print "  a  b  c  d  e  f  g  h\n\n"
  end

  def get_square(coords)
    @board[coords[0]][coords[1]]
  end

  def set_square(coords, value)
    @board[coords[0]][coords[1]] = value
  end

  def make_move(start, finish)
    if valid_move?(start, finish) && correct_color?(start, finish)
      piece = get_square(start)
      set_square(finish, piece)
      set_square(start, nil)
    else
      false # is nil a good return?
    end
  end

  def correct_color?(start, finish)
    unless get_square(start).nil? || get_square(finish).nil?
      get_square(start).color != get_square(finish).color
    else
      return true unless get_square(start).nil?
    end
    false
  end

  def valid_move?(start, finish)
    # assume the correct color and an actual pices exists in the start position
    start_square = get_square(start)
    finish_square = get_square(finish)
    possible_moves = start_square.all_moves(start).dup # nested array
    direction = possible_moves.select { |direction| direction == finish || direction.include?(finish) }[0]
    if not direction.nil?
      path = extract_path(direction, finish)

      if blocked?(path)
        return false
      else
        ##check color, and if occupied, delete occupant
        return true
      end
    else
      return false
    end

  end

  def extract_path(direction, finish)
    index = direction.index(finish)
    direction[0..index]
  end

  def blocked?(path)
    path.each do |square|
      unless get_square(square).nil?
        return get_square(square) != get_square(path.last)
      end
    end
    false
  end

  def find_king(color)
    (0..7).each do |row|
      (0..7).each do |col|
        if @board[row][col].is_a?(King) && @board[row][col].color == color
          return [row, col]
        end
      end
    end
  end

  def check?(color)
    king_pos = find_king(color)
    @board.each_with_index do |row, row_num|
      row.each_with_index do |square, col|
        next if square.nil?
        next if square.color == color
        return true if self.valid_move?([row_num, col], king_pos)
      end
    end
    false
  end

  def dup
    duplicate = []
    @board.each do |row|
      duplicate_row = []
      row.each do |square|
        if square.nil?
          duplicate_row << nil
          next
        end
        duplicate_row << square.dup
      end
      duplicate << duplicate_row
    end
    board = Board.new
    board.board = duplicate
    board
  end

  def check_mate?(color)
    # get all pieces of color do
      # grab possible moves
      # fake out move
      # see if still in check
    # end

    # pieces_with_positions_for(color).each do |piece, pos|
      # piece.possible_moves.each do |move|
        # shadow_board = self.dup
        # shadow_board.try_move(move)
        # return false unless shadow_board.check?(color)
      # end
    # end
    # true

    @board.each_with_index do |row, row_num|
      row.each_with_index do |square, col_num|
        next if square.nil?
        next if square.color != color

        next_moves = square.all_moves([row_num, col_num])

        next_moves.each do |future_directions|
          future_directions.each do |future_move|

            dupped_board = self.dup
            next unless dupped_board.valid_move?([row_num, col_num], future_move)
            dupped_board.make_move([row_num, col_num], future_move)
            return false unless dupped_board.check?(color)
          end
        end
      end
    end
    true
  end
end




