# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/board'

describe Game do
  describe '#play' do
    # test internal functions instead
  end

  describe '#turn_order' do
    context 'when a player has made a move' do
      subject(:game) { described_class.new }

      before do
        allow(instance_double(Board)).to receive(:update)
      end

      it 'reverses player que when called' do
        player1 = game.instance_variable_get(:@player1)
        player2 = game.instance_variable_get(:@player2)
        reversed_que = [player2, player1]
        expect { game.turn_order }.to change { game.instance_variable_get(:@player_que) }.to(reversed_que)
      end
    end

    it 'updates board based on where player drops piece' do
      # test board function for updating
    end
  end

  describe '#end_game?' do
    context 'when game has a winner' do
      it 'returns true' do
        # test board function for checking a winning condition in the board
      end
    end

    context 'when board is full' do
      it 'returns true' do
        # test board function for checking if board is full
      end
    end
  end

  describe '#end_cause' do
    context 'when end game was due to winner' do
      let(:player1) { double('Player', name: player1) }
      subject(:game) { described_class.new }

      it 'reports the winner' do
        end_cause = game.end_cause
        expected_message = "Game over: #{player1.name} won"
        expect(end_cause).to eql(expected_message)
      end
    end

    context 'when end game was due to full board' do
      let(:board) { double('Board', full?: true) }
      subject(:game) { described_class.new }

      it 'reports that the board was full' do
        end_cause = game.end_cause
        expected_message = 'Game over: Draw'
        expect(end_cause).to eql(expected_message)
      end
    end
  end

  describe '#winner' do
    # winner returns the name of the winner
    let(:player1) { double('Player', name: 'player1', piece: "\u2660") } # spade
    let(:player2) { double('Player', name: 'player2', piece: "\u2666") } # diamond

    context 'winning piece is spade u2660' do
      it 'returns the name of player1' do
        winner_name = winner("\u2660")
        expected_name = 'player1'

        expect(winner_name).to be(expected_name)
      end
    end

    context 'winning piece is spade u2666' do
      it 'returns the name of player2' do
        winner_name = winner("\u2666")
        expected_name = 'player2'

        expect(winner_name).to be(expected_name)
      end
    end
  end
end
