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

  describe '#update' do
    let(:piece) { " \u2660 " }

    it 'places piece on the column of bottomest empty row position' do; end

    context 'when placing on an empty column' do
      subject(:board) { described_class.new }

      context 'when placing on column 2' do
        let(:cells) { board.instance_variable_get(:@cells) }

        it 'places piece on column 2 of row 6' do
          expect { board.update(piece, 2) }.to change { cells[6][2] }.to(piece)
        end
      end
    end

    context 'when placing on column where a row is occupied' do
      context 'when placing on column 5 and row 2 is occupied' do
        before do
          # make some array and set that to cells
        end

        it 'places piece on column 5 of row 1' do
          expect { board.update(piece, 5) }. to change { cells[1][5] }.to(piece)
        end
      end
    end
  end

  describe '#winner' do; end

  describe '#full?' do; end
end
