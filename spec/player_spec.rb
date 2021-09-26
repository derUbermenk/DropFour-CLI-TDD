# frozen_string_literal: true

require_relative '../lib/player'

describe Player do
  subject(:player) { described_class.new('player1', "\u2660") }
  describe '#choose_column' do
    let(:choices) { [2, 3, 6] }
    before do
      allow(player).to receive(:error_message).with(choices)
      allow(player).to receive(:instruction_message).with(choices)
    end
    context 'when user\'s input is valid in first input' do
      before do
        allow(player).to receive(:get_input).and_return(6)
      end

      it 'does not call puts with error message' do
        expect(player).to_not receive(:error_message).with(choices)
        player.choose_column(choices)
      end

      context 'when user input is 6' do
        it 'returns 6' do
          expected_return = 6
          return_val = player.choose_column(choices)
          expect(return_val).to eql(expected_return)
        end
      end
    end

    context 'when user\'s input is invalid two times and valid in the third time' do
      before do
        allow(player).to receive(:get_input).and_return(9, 10, 6)
      end

      it 'calls puts with instruction message thrice' do
        expect(player).to receive(:instruction_message).with(choices)
        player.choose_column(choices)
      end

      it 'calls puts with error message twice' do
        expect(player).to receive(:error_message).with(choices)
        player.choose_column(choices)
      end

      context 'when proper input was 6' do

        it 'returns 6' do
          expected_return = 6
          return_value = player.choose_column(choices)
          expect(return_value).to eql(expected_return)
        end
      end
    end
  end
end
