# encoding: utf-8

#  http://en.wikipedia.org/wiki/Chess_symbols_in_Unicode

module Movable
   HORIZONTAL = [
    [-1,  0],
    [ 0, -1],
    [ 0,  1],
    [ 1,  0]
  ]

   DIAGONAL = [
    [-1, -1],
    [-1,  1],
    [ 1, -1],
    [ 1,  1]
  ]

  def diagonals(current_position, steps=7)
    diagonals = []
    DIAGONAL.each do |vector|
      diagonals << (1..steps).map do |step|
        valid_steps(vector, current_position, step)
      end.compact
    end
    diagonals
  end

  def horizontals(current_position, steps=7)
    horizontals = []
    HORIZONTAL.each do |vector|
      horizontals << (1..steps).map do |step|
        valid_steps(vector, current_position, step)
      end.compact
    end
    horizontals
  end

  def valid_steps(vector1, position, multiplier)
    x = (vector1[0] * multiplier ) + position[0]
    y = (vector1[1] * multiplier ) + position[1]
    if x < 0 || y < 0 # I need a better way to deal with these nils
      nil
    elsif x > 7 || y > 7
      nil
    else
      [x , y]
    end
  end
end


class Pawn
  include Movable
  attr_accessor :moved
  attr_reader :direction, :name, :color
  def initialize(color)
    @color = color
    @name = '♙'
    @moved = false
    set_direction
  end

  def all_moves(current_position, steps=2)
    if moved
      [ horizontals(current_position, steps)[direction][0] ]
    else
      [ horizontals(current_position, steps)[direction][0..1] ]
    end
  end

  # two edge cases
  # - pawn can go two moves at first
  # - pawn can move diagonally to take another piece

  def take(current_position)
    if direction == 1
      diagonals(current_position, 1)[0..1]
    elsif direction == 2
      diagonals(current_position, 1)[1...-1]
    end
  end

  def set_direction
    if @color == :w
      @direction = 0
    elsif @color == :b
      @direction = -1
    end
  end
end

class Rook
  include Movable
  attr_reader :name, :color
  def initialize(color)
    @color = color
    @name = '♖'
  end

  def all_moves(current_position)
    horizontals(current_position)
  end
end

class King
  include Movable
  attr_reader :name, :color
  def initialize(color)
    @color = color
    @name = '♔'
  end

  def all_moves(current_position)
    horizontals(current_position, 1) + diagonals(current_position, 1)
  end
end

class Queen
  include Movable
  attr_reader :name, :color
  def initialize(color)
    @color = color
    @name = '♕'
  end

  def all_moves(current_position)
    horizontals(current_position) + diagonals(current_position)
  end
end

class Bishop
  include Movable
  attr_reader :name, :color
  def initialize(color)
    @color = color
    @name = '♗'
  end

  def all_moves(current_position)
    diagonals(current_position)
  end
end

class Knight
  include Movable
  attr_reader :name, :color
  def initialize(color)
    @vectors = [
      [2,1], [2,-1], [-2,-1], [-2,1],
      [1,2], [1,-2], [-1,2], [-1,-2]
    ]
    @color = color
    @name = '♘'
  end

  def all_moves(current_position)
    moves = []
    @vectors.each do |vector|
      moves << valid_steps(vector, current_position, 1)
    end
    Array.new(1) { moves.compact }
  end
end


