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
# options = :diagonal or :perpendicular
  def generate_moves(option)
    raise "Specify which directions are allowed" if option.nil?
    deltas = DELTA_HASH[option]
    @pos_moves = []
    deltas.each do |delta|
      possible_pos = [@pos[0] + delta[0], @pos[1] + delta[1]]
      while in_bounds?(possible_pos) && board[possible_pos].nil?
        @pos_moves << possible_pos
        possible_pos = [ possible_pos[0] + delta[0] , possible_pos[1] + delta[1] ]
      end
      if in_bounds?(possible_pos)
        @pos_moves << possible_pos if board[possible_pos].color != self.color
      end
    end

    @pos_moves
  end

end
