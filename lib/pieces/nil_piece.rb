require_relative 'piece.rb'
require "colorize"

class NilPiece < Piece
  def initialize()
    super(pos=nil, color=:default, board = nil)
  end

  def to_s
    "   ".colorize(color)
  end

end
