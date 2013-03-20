require 'debugger'

class Piece
  attr_accessor :spaces, :vectors
  def initialize(color)
    @color = color
  end

  def possible_moves(current_position)
    possible_moves = []
    current_x = current_position[0]
    current_y = current_position[1]

    vectors.each do |vector|
      (1..@max_distance).each do |multiplier|
        v_x = (vector[0] * multiplier) + current_x
        v_y = (vector[1] * multiplier) + current_y
        break if v_x > 7 || v_x < 0
        break if v_y > 7 || v_y < 0
        possible_moves << [v_x, v_y]
      end
    end
    possible_moves
  end
end


class Pawn < Piece
  attr_accessor :moved
  def initialize(color)
    super
    self.vectors = [[-1,0]] if color == :b
    self.vectors = [[ 1,0]] if color == :w
    moved = false
    @max_distance = 1
  end

end

class Rook < Piece
  def initialize(color)
    super
    self.vectors = [
                    [-1,0],[1,0],[0,-1],[0,1]
                   ]
    @max_distance = 7
  end
end

class King < Piece
  def initialize(color)
    super
    self.vectors = [
                    [-1,0],  [1,0],  [0,-1], [0,1],
                    [-1,-1], [-1,1], [1,1],  [1,-1]
                   ]
  end
end

class Queen < Piece
  def initialize(color)
    super
    self.vectors = [
                    [-1,0],  [1,0],  [0,-1], [0,1],
                    [-1,-1], [-1,1], [1,1],  [1,-1]
                   ]
    @max_distance = 7
  end
end

class Bishop < Piece
  def initialize(color)
    super
    self.vectors = [
                    [-1,-1], [-1,1], [1,1], [1-1]
                   ]
    @max_distance = 7
  end
end

class Knight < Piece
  def initialize(color)
    super
    self.vectors = [
                    [2,1], [2,-1], [-2,-1], [-2,1],
                    [1,2], [1,-2], [-1,2],  [-1,-2]
                   ]
    @max_distance = 1
  end

end






