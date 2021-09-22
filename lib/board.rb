# require frozen_string_literal: true

# Contains dropped pieces by a player object
class Board
  def initialize
    @cells = Array.new(6) { Array.new(7, nil) }
  end

  def update(combo); end

  # returns last piece added if winner
  # @return [String] unicode for last piece added
  def winner; end

  # checks if board is full
  def full?; end
end
