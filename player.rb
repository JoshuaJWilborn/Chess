class Player
  attr_accessor :color
  def initalize(color)
    @color = color
  end

  def get_move(start, finish)
    puts "What pices would you like to move?"
    start = gets.chomp
    puts "Where would you like to move it?"
    finish = gets.chomps
    # parse this response, for the game class
  end
end