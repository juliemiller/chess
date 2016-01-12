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
    @board[[2,2]] = Piece.new([2,2], :white, @board)
    @board[[3,3]] = Bishop.new([3,3], :white, @board)
    @board[[3,3]].moves
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
      bg = :light_red
    elsif (i + j).odd?
      bg = :light_white
    else
      bg = :light_black
    end
    { background: bg, color: :white }
  end

  def render
    system("clear")
    puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
    build_grid.each { |row| puts row.join }
  end

  def run
    puts "Mark all the spaces on the board!"
    puts "WASD or arrow keys to move the cursor, enter or space to confirm."
    until @board.full?
      render
      pos = get_input
    end
    puts "Hooray, the board is filled!"
  end
end
