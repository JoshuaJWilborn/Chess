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

  def valid_steps(vector1, vector2, multiplier)
    x = (vector1[0] * multiplier ) + vector2[0]
    y = (vector1[1] * multiplier ) + vector2[1]
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
  attr_reader :direction
  def initialize(color)
    @color = color
    set_direction
  end

  # two edge cases 
  # - pawn can go two moves at first 
  # - pawn can move diagonally to take another piece 

  def all_moves(current_position, steps=1)
    horizontals(current_position, steps)[direction] 
  end

  def take(current_position)
    if direction == 1 
      diagonals(current_position, 1)[0..1]
    elsif direction == 2
      diagonals(current_position, 1)[1...-1]
    end
  end

  def set_direction
    if @color == :w
      @direction = 1 
    elsif @color == :b
      @direction = 2
    end
  end
end

class Rook 
  include Movable 
  def initialize(color)
    @color = color
  end

  def all_moves(current_position)
    horizontals(current_position)
  end
end

class King 
  include Movable 
  def initialize(color)
    @color = color
  end

  def all_moves(current_position)
    horizontals(current_position, 1)
  end
end

class Queen
  include Movable 
  def initialize(color)
    @color = color
    @max_distance = 7
  end

  def all_moves(current_position)
    horizontals(current_position) + diagonals(current_position)
  end
end

class Bishop 
  include Movable
  def initialize(color)
    @color = color
    @max_distance = 7
  end

  def all_moves(current_position)
    diagonals(current_position)
  end
end

class Knight 
  include Movable
  def initialize(color)
    @vectors = [ 
      [2,1], [2,-1], [-2,-1], [-2,1],
      [1,2], [1,-2], [-1,2], [-1,-2]
    ]
    @color = color
    @max_distance = 1
  end

  def all_moves(current_position)
    moves = []
    @vectors.each do |vector|
      moves << valid_steps(vector, current_position, 1)
    end
    moves.compact
  end
end


