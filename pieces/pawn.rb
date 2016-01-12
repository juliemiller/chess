require_relative 'pieces'
class Pawn < Piece

  def initialize(pos, color, board)
    super(pos, color, board)
  end

  def to_s
    " ♟ ".colorize(color)
  end
  DELTA_WHITE = [[-1,0],[-2,0]]
  DELTA_BLACK = [[1,0], [2,0]]
  DELTA_BLACK_KILL = [[1,1], [1,-1]]
  DELTA_WHITE_KILL = [[-1,1], [-1,-1]]

  def moves
    @pos_moves = []
    if self.color == :black
      if @pos[0] == 1
        DELTA_BLACK.each_with_index do |el, idx|
          new_move = [el[0] + @pos[0], el[1] + @pos[1]]
          if @pos_moves.empty? && idx ==1
          elsif @board[new_move].nil?
            @pos_moves << new_move
          end
        end
      else
        new_move = [@pos[0] + DELTA_BLACK[0][0], @pos[1] + DELTA_BLACK[0][1]]
        @pos_moves << new_move if @board[new_move].nil?
      end
      DELTA_BLACK_KILL.each do |el|
        new_move = [el[0] + @pos[0], el[1] + @pos[1]]
        @pos_moves << new_move if !@board[new_move].nil? && @board[new_move].color != self.color
      end

    else self.color == :white
      if @pos[0] == 6
        DELTA_WHITE.each_with_index do |el, idx|
          new_move = [el[0] + @pos[0], el[1] + @pos[1]]
          if @pos_moves.empty? && idx ==1
          elsif @board[new_move].nil?
            @pos_moves << new_move
          end
        end
      else
        new_move = [ @pos[0] + DELTA_WHITE[0][0], @pos[1] + DELTA_WHITE[0][1] ]
        @pos_moves << new_move if @board[new_move].nil?
      end
      DELTA_WHITE_KILL.each do |el|
        new_move = [el[0] + @pos[0], el[1] + @pos[1]]
        @pos_moves << new_move if !@board[new_move].nil? && @board[new_move].color != self.color
      end
    end

    @pos_moves.select { |move| in_bounds?(move)}
  end

end
