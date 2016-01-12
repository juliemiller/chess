require_relative 'piece'

class SteppingPiece < Piece

  def initialize(pos, color, board)
    super(pos, color, board)
  end

  DELTA_PER = [[1,0], [0,1], [-1,0], [0,-1]]
  DELTA_DIAGONAL = [[1,1], [-1,1], [-1,-1], [1,-1]]
  DELTA_KNIGHT = [ [2,1], [-2,1], [2,-1], [-2,-1], [1,2], [-1,2], [1,-2], [-1,-2] ]
  DELTA_HASH = {:knight => DELTA_KNIGHT,
                :king => DELTA_DIAGONAL + DELTA_PER
                }

  def generate_moves(option)
    raise "Specify which directions are allowed" if option.nil?
    deltas = DELTA_HASH[option]
    @pos_moves = []
    deltas.each do |delta|
      new_pos = [delta[0] + @pos[0], delta[1] + @pos[1]]
      @pos_moves << new_pos if in_bounds?(new_pos) &&
                              (@board[new_pos].nil? ||
                              @board[new_pos].color != self.color)
    end
    @pos_moves
  end
end
