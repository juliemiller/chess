require_relative 'piece'

class SlidingPiece < Piece

  def initialize(pos, color, board)
    super(pos, color, board)
  end

  DELTA_PER = [[1,0], [0,1], [-1,0], [0,-1]]
  DELTA_DIAGONAL = [[1,1], [-1,1], [-1,-1], [1,-1]]
  DELTA_HASH = {:diagonal => DELTA_DIAGONAL,
                :perpendicular => DELTA_PER,
                :all => DELTA_DIAGONAL + DELTA_PER
                }
  def generate_moves(option)
    raise "Specify which directions are allowed" unless DELTA_HASH.keys.include?(option)
    deltas = DELTA_HASH[option]
    @pos_moves = []
    deltas.each do |delta|
      possible_pos = [@pos[0] + delta[0], @pos[1] + delta[1]]
      while in_bounds?(possible_pos) && board[possible_pos].class == NilPiece
        @pos_moves << possible_pos
        possible_pos = [ possible_pos[0] + delta[0] , possible_pos[1] + delta[1] ]
      end
      @pos_moves << possible_pos if in_bounds?(possible_pos) && opponent?(possible_pos)
    end

    @pos_moves
  end

end
