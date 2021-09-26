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
        allow_any_instance_of(Player).to receive(:choose_column).and_return(2)
      end

      it 'reverses player que when called' do
        rotated_que = game.instance_variable_get(:@player_que).rotate
        expect { game.turn_order }.to change { game.instance_variable_get(:@player_que) }.to(rotated_que)
      end
    end

    it 'updates board based on where player drops piece' do
      # test board function for updating
    end

    it 'shows board' do; end
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
    context 'when end game was due to having a winner' do
      let(:player1) { double('Player', name: 'player1', code: "\u2660") }
      subject(:game) { described_class.new }

      before do
        board = game.instance_variable_get(:@board)
        allow(board).to receive(:winner).and_return("\u2660")
      end

      it 'reports the winner' do
        expected_message = "Game over: #{player1.name} won"
        end_cause = game.end_cause
        expect(end_cause).to eql(expected_message)
      end
    end

    context 'when end game was due to full board' do
      let(:board) { double('Board') }
      subject(:game) { described_class.new }

      before do
        allow(board).to receive(:winner).and_return(nil)
        allow(board).to receive(:full?).and_return(true)
        game.instance_variable_set(:@board, board)
      end

      it 'reports that the board was full' do
        expected_message = 'Game over: Draw'
        end_cause = game.end_cause
        expect(end_cause).to eql(expected_message)
      end
    end
  end

  describe '#find_winner' do
    # winner returns the name of the winner
    let(:player1) { double('Player', name: 'player1', piece: "\u2660") } # spade
    let(:player2) { double('Player', name: 'player2', piece: "\u2666") } # diamond
    subject(:game) { described_class.new }

    before do
      game.instance_variable_set(:@player1, player1)
      game.instance_variable_set(:@player2, player2)
    end

    context 'winning piece is spade u2660' do
      it 'returns the name of player1' do
        winner_name = game.find_winner("\u2660")
        expected_name = 'player1'

        expect(winner_name).to eql(expected_name)
      end
    end

    context 'winning piece is spade u2666' do
      it 'returns the name of player2' do
        winner_name = game.find_winner("\u2666")
        expected_name = 'player2'

        expect(winner_name).to eql(expected_name)
      end
    end
  end
end
