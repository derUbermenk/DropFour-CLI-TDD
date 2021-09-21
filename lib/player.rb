# frozen_string_literal: true

class Player 
  attr_reader :piece
  def initialize(name, piece) 
    @name = name
    @piece = piece 
  end

  def place_piece
  end
end