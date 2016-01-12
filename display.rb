require 'colorize'
require_relative 'cursorable'
require_relative 'board.rb'
require_relative 'pieces/pieces.rb'

class Display
  include Cursorable
  attr_reader :board

  def initialize(board = nil)
    board ||= Board.new
    @board = board
    @cursor_pos = [0,0]
    # @board[[5,2]] = Pawn.new([5,2], :white, @board)
    # @board[[6,3]] = Pawn.new([6,3], :white, @board)
    # @board[[6,3]].moves
  end

  def build_grid
    @board.grid.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :green
    elsif (i + j).odd?
      bg = :magenta
    else
      bg = :light_blue
    end
    { background: bg } #, color: :black
  end

  def render
    # system("clear")
    puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
    build_grid.each { |row| puts row.join }
  end

  def run
    puts "WASD or arrow keys to move the cursor, enter or space to confirm."
    until @board.win?
      render
      start_pos = get_input
      end_pos = get_input
      @board.move(start_pos, end_pos)
    end

  end
end

# b = Display.new
# b.run
# b.board.move!([1,0],[2,0])
# b.render
# p b.board[[2,0]].pos
# c = b.board.dup
# d = Display.new(c)
# d.board.move!([2,0],[3,0])
# d.render
# b.render
