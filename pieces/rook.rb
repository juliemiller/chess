require_relative 'sliding_pieces.rb'
require "colorize"

class Rook < SlidingPiece

  def initialize(pos, color, board)
    super(pos, color, board)
  end

  def to_s
    "♜".colorize(color)
  end

  def moves
    @pos_moves = generate_moves(:perpendicular)
  end
end
