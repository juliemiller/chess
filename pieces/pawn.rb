require_relative 'pieces'
class Pawn < Piece

  def initialize(pos, color, board)
    super(pos, color, board)
  end

  def to_s
    " ♟ ".colorize(color)
  end

  DELTA_HASH = {:black => [[1,0], [2,0]],
                :white => [[-1,0],[-2,0]]
              }
  DELTA_KILL = { :black => [[1,1], [1,-1]],
                 :white => [[-1,1], [-1,-1]]
                }
  INITIAL_POS = { :black => 1,
                  :white => 6
                  }

  def generate_kill_moves
    pos_moves =[]
    DELTA_KILL[self.color].each do |el|
      new_move = [el[0] + @pos[0], el[1] + @pos[1]]
      pos_moves << new_move if opponent?(new_move)
    end
    pos_moves
  end

  def generate_normal_moves
    pos_moves =[]
    if @pos[0] == INITIAL_POS[self.color]
      DELTA_HASH[self.color].each_with_index do |el, idx|
        new_move = [el[0] + @pos[0], el[1] + @pos[1]]
        if !(pos_moves.empty? && idx == 1) && @board[new_move].class == NilPiece
          pos_moves << new_move
        end
      end
    else
      new_move = [@pos[0] + DELTA_HASH[self.color][0][0], @pos[1] + DELTA_HASH[self.color][0][1]]
      pos_moves << new_move if @board[new_move].class == NilPiece
    end
    pos_moves
  end

  def moves
    @pos_moves = []

    @pos_moves += generate_normal_moves + generate_kill_moves

    @pos_moves = @pos_moves.select { |move| in_bounds?(move)}
  end

end
