# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe '#initialize' do
    subject(:board) { described_class.new }
    matcher :be_of_size_7 do
      match { |something| something.size == 7 }
    end

    it 'creates 6 rows' do
      cells_size = board.instance_variable_get(:@cells).size
      expect(cells_size).to eq(6) 
    end

    it 'creates rows with 7 nil positions' do
      cells = board.instance_variable_get(:@cells)
      expect(cells).to all(be_of_size_7. and include(nil).exactly(7).times)
    end
  end

  describe '#drop_piece' do
    let(:piece) { "\u2660" }

    context 'when placing on an empty column' do
      context 'when placing on column 2' do
        subject(:board) { described_class.new }
        let(:cells) { board.instance_variable_get(:@cells) }

        it 'places piece on column 2 of row 6' do
          expect { board.drop_piece(piece, 2) }.to change { cells[5][2] }.to(piece)
        end
      end
    end

    context 'when placing on column where a row is occupied' do
      context 'when placing on column 5 and row 2 is occupied' do
        subject(:board) { described_class.new }
        let(:cells) { board.instance_variable_get(:@cells) }

        before do
          semi_filled_board = Array.new(6) do |index|
            index >= 2 ? Array.new(7, piece) : Array.new(7, nil)
          end

          board.instance_variable_set(:@cells, semi_filled_board)
        end

        it 'places piece on column 5 of row 1' do
          expect { board.drop_piece(piece, 5) }.to change { cells[1][5] }.to(piece)
        end
      end
    end
  end

  describe '#winner' do 
    subject(:board) { described_class.new }
    let(:spade) { "\u2660" }
    let(:diamond) { "\u2666" }
    context 'when winning piece forms a horizontal line' do
      before do

        # create some board
        winned_board = Array.new(6) do |index|
          index >= 1 ? Array.new(7, diamond) : Array.new(7, nil)
        end

        # edit board for a winning condition
        winned_board[2][2] = spade
        winned_board[2][3] = spade
        winned_board[2][4] = spade
        winned_board[2][5] = spade

        # for some variety added some spades too
        winned_board[3][5] = spade
        winned_board[1][2] = spade


        board.instance_variable_set(:@cells, winned_board)
      end

      it 'returns winning piece' do
        winning_piece = board.winner
        expect(winning_piece).to eql(spade)
      end
    end

    context 'when winning piece forms a vertical line' do
      before do
        # let winning piece be spade
        # create a condition where spade forms a vertical line
        winned_board = Array.new(6) do |index|
          index >= 1 ? Array.new(7, diamond) : Array.new(7, nil)
        end

        # create the winning line
        winned_board[2][1] = spade
        winned_board[3][1] = spade
        winned_board[4][1] = spade
        winned_board[5][1] = spade

        # add some other spades for variety
        winned_board[2][2] = spade
        winned_board[3][1] = spade

        board.instance_variable_set(:@cells, winned_board)
      end
      it 'returns winning piece' do
        winning_piece = board.winner
        expect(winning_piece).to eql(spade)
      end
    end

    context 'when winning piece forms a diagonal line' do
      before do
        # let winnning piece be diamond
        # create a condition where spade forms a horizontal line
        winned_board = Array.new(6) do |index|
          index >= 1 ? Array.new(7, diamond) : Array.new(7, nil)
        end

        # create the diagonal line
        winned_board[0][3]
        winned_board[1][2]
        winned_board[2][1]
        winned_board[3][0]

        # add other spades for variety
        winned_board[0][1]
        winned_board[2][0]

        board.instance_variable_set(:@cells, winned_board)
      end

      it 'returns winning piece' do
        winning_piece = board.winner
        expect(winning_piece).to eql(spade)
      end
    end
  end

  describe '#horizontal_match' do
    subject(:board) { described_class.new }
    let(:piece) {"\u2660"}
    context 'when there is match' do
      before do
        matching_row = [nil, nil, piece, piece, piece, piece, nil]
        allow(board).to receive(:get_row_elements).and_return(matching_row)
      end
      it 'returns true' do
        match_check = board.horizontal_match
        expect(match_check).to be true 
      end
    end

    context 'when there is no match' do
      before do
        matching_row = [nil, nil, piece, nil, piece, piece, nil]
        allow(board).to receive(:get_row_elements).and_return(matching_row)
        allow(board).to receive(:create_pattern).and_return(piece+piece+piece+piece)
      end

      it 'returns false' do
        match_check = board.horizontal_match
        expect(match_check).to be false 
      end
    end
  end

  describe '#vertical_match' do
    context 'when there is no match' do
      it 'returns false' do
      end
    end

    context 'when there is match' do
      it 'returns true' do
      end
    end
  end

  describe 'diagonal_match' do
    context 'when there is no match' do
      it 'returns false' do
      end
    end

    context 'when there is match' do
      it 'returns true' do
      end
    end
  end

  describe '#full?' do
    subject(:board) { described_class.new }
    let(:piece) { "\u2660" }

    context 'when board is full?' do
      before do
        filled_board = Array.new(6) {Array.new(7, piece)}


        board.instance_variable_set(:@cells, filled_board)
      end

      it 'returns true' do
        expect(board).to be_full
      end
    end

    context 'when board is semi full?' do

      before do
        semi_filled_board = Array.new(6) do |index|
          index >= 2 ? Array.new(7, piece) : Array.new(7, nil)
        end

        board.instance_variable_set(:@cells, semi_filled_board)
      end

      it 'returns false' do
        expect(board).to_not be_full
      end
    end

    context 'when board is empty' do
      it 'returns false' do
        expect(board).to_not be_full
      end
    end
  end
end
