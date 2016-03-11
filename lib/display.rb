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
    { background: bg }
  end

  def render(player)
    system("clear")
    puts "Use the Arrow keys or WASD to move."
    puts "Select a piece and confirm your move using space or enter."
    puts "#{player.to_s}'s turn"
    puts "You're in check" if @board.board_status == :check
    build_grid.each { |row| puts row.join }
  end

end

