class Player
  POSITION_MAP = {
    'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4, 'f' => 5, 'g' => 6,
    'h' => 7, '8' => 0, '7' => 1, '6' => 2, '5' => 3, '4' => 4, '3' => 5,
    '2' => 6, '1' => 7
  }

  attr_accessor :color, :name
  def initialize(name, color)

    @name = name
    @color = color
  end

  def get_move

    puts "What pieces would you like to move, #{self.name}? (#{color.to_s})"
    start = gets.chomp.split('')
    start = [ POSITION_MAP[start[0]], POSITION_MAP[start[1]] ]
    puts "Where would you like to move it?"
    finish = gets.chomp.split('')
    finish = [ POSITION_MAP[finish[0]], POSITION_MAP[finish[1]] ]
    [start, finish]
    # parse this response, for the game class
  end
end