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
    { background: bg } #, color: :black
  end

  def render(player)
    system("clear")
    puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
    puts "#{player.to_s}'s turn"
    puts "You're in check" if @board.board_status == :check
    build_grid.each { |row| puts row.join }
  end

  # def run
  #   color = :white
  #   until @board.checkmate?(color)
  #   begin
  #     render
  #     start_pos = nil
  #     until start_pos
  #       render
  #       puts "Pick a piece!"
  #       p @cursor_pos
  #       start_pos = get_input
  #     end
  #     end_pos = nil
  #     until end_pos
  #       render
  #       puts "Where do you want to move it?"
  #       p @cursor_pos
  #       end_pos = get_input
  #     end
  #     @board.move(start_pos, end_pos)
  #   rescue
  #     puts "Not a valid move!"
  #     sleep(1)
  #     retry
  #   end
  #   color == :black ? color = :white : color = :black
  #   end
  #   render
  # end
end
d = Display.new
