require_relative 'stepping_pieces.rb'
require "colorize"

class Knight < SteppingPiece

  def initialize(pos, color, board)
    super(pos, color, board)
  end

  def to_s
    "♞".colorize(color)
  end

  def moves
    generate_moves(:knight)
  end
end
