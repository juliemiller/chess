require_relative 'pieces'
class Pawn < Piece
  attr_reader :pos_moves
  def initialize(pos, color, board)
    super(pos, color, board)
  end

  def to_s
    "♟".colorize(color)
  end
  DELTA_WHITE = [[-1,0],[-2,0]]
  DELTA_BLACK = [[1,0], [2,0]]
  DELTA_BLACK_KILL = [[1,1], [1,-1]]
  DELTA_WHITE_KILL = [[-1,1], [-1,-1]]

  def moves
    @pos_moves = []
    if self.color == :black
      if self.pos[0] == 6
        @pos_moves = DELTA_BLACK.map do |el|
          [el[0] + self[0], el[1] + self[1]]
        end
      end
      DELTA_BLACK_KILL.each do |el|
        new_pos = [el[0] + self[0], el[1] + self[1]]
        @pos_moves << new_pos if !@board[new_pos].nil? && @board[new_pos].color != self.color
      end

    else self.color == :white
      if self.pos[0] == 1
        @pos_moves = DELTA_WHITE.map do |el|
          [el[0] + self[0], el[1] + self[1]]
        end
      end
      DELTA_WHITE_KILL.each do |el|
        new_pos = [el[0] + self[0], el[1] + self[1]]
        @pos_moves << new_pos if !@board[new_pos].nil? && @board[new_pos].color != self.color
      end
    end

    @pos_moves.select { |move| on_board?(move)}
  end

  def attack

  end
end
