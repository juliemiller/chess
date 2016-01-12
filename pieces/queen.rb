require_relative 'sliding_pieces.rb'
require "colorize"

class Queen < SlidingPiece

  def initialize(pos, color, board)
    super(pos, color, board)
  end

  def to_s
    "♕".colorize(color)
  end

  def moves
    generate_moves(:all)
  end
end
