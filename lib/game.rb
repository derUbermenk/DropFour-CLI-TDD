# frozen_string_literal: true

require_relative './player'
require_relative './board'

# Contains functions for starting a game loop and checking for end game conditions
class Game
  def initialize
    @player1 = Player.new('player1', "\u2660") # player1 has spade
    @player2 = Player.new('player2', "\u2666") # player2 has diamond
    @board = Board.new

    @player_que = [@player1, @player2]
  end

  def play
    turn_order until end_game?
    puts end_cause
  end

  def turn_order
    curr_player = @player_que.first
    @board.drop_piece(curr_player.piece, 
                      curr_player.choose_column(@board.unfilled_columns))
    @player_que.rotate!
    @board.display
 end

  def end_game?
    # board.winner returns nil if none
    @board.winner || @board.full?
  end

  def end_cause
    if @board.winner
      "Game over: #{find_winner(@board.winner)} won"
    elsif @board.full?
      'Game over: Draw'
    end
  end

  def find_winner(piece)
    case piece
    when @player1.piece then @player1.name
    when @player2.piece then @player2.name
    end
  end
end

def main
  game = Game.new
  game.play
end

main
