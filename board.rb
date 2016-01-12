class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) {Array.new(8) {nil}}
  end

  def move(start_pos, end_pos)

    raise "There is no piece to move" if self[start_pos].nil?
    raise "You cannot move there with that piece" unless valid_move?(start_pos, end_pos)
  end

  def valid_move?(start_pos, end_pos)

  end

  def in_bounds?(pos)
    row, col = pos
    row.between?(0, 7) && col.between?(0, 7)
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    grid[row][col] = value
  end

  def full?       #game_over
    false
  end
end
