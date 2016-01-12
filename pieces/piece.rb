require "colorize"
class Piece
  attr_reader :board, :color
  attr_accessor :pos_moves, :pos

  def initialize (pos, color, board)
    @pos = pos
    @board = board
    @color = color
    @pos_moves =[]
  end

  def inspect
    self.class
  end

  def to_s
    "   ".colorize(color)
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

  def dup(board)
    if self.class == NilPiece
      duped_piece = NilPiece.new
    else
      duped_piece = self.class.new(@pos.dup, @color, board)
      duped_piece.pos_moves = deep_dup(@pos_moves) unless @pos.nil?
    end
    duped_piece
  end

  def deep_dup(array)
    return array if array.empty?
    dup = []
    array.each do |el|
      if el.is_a?(Array)
        dup << deep_dup(el)
      else
        dup << el
      end
    end
    dup
  end

  def put_in_check?
    @pos_moves.each do |position|
      if @board[position].class == King && opponent?(position)
        return true
      end
    end
    false
  end

  def opponent?(pos)
    return false if @board[pos].class == NilPiece || @board[pos].nil?
    return true if @board[pos].color != self.color
    false
  end

end
