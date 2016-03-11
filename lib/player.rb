require 'colorize'
require_relative 'cursorable'
require_relative 'display.rb'

class HumanPlayer
  include Cursorable
  attr_reader :color

  def initialize(display, color)
    @display = display
    @color = color
  end

  def take_turn
    input_pos = nil
    until input_pos
      @display.render(self)
      input_pos = @display.get_input
    end
    input_pos
  end

  def to_s
    @color.to_s.capitalize
  end

end
