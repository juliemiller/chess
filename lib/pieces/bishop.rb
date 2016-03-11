require "colorize"
require_relative 'sliding_pieces.rb'

class Bishop < SlidingPiece

  def initialize(pos, color, board)
    super(pos, color, board)
  end

  def to_s
    " ♝ ".colorize(color)
  end

  def moves
    generate_moves(:diagonal)
  end
end
