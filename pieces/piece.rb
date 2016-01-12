class Piece
  attr_reader :pos, :board, :color

  def initialize (pos, color, board)
    @pos = pos
    @board = board
    @color = color #black or white
  end

  def moves
    pos_moves =[]
    pos_moves
  end

  def in_bounds?(pos)
    @board.in_bounds?(pos)
  end

  def die
    @pos = [nil, nil]
  end
end
