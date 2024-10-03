# frozen_string_literal: true

require_relative '../../recursion/project/fibonacci'

RSpec.describe '#fibonacci' do
  context 'when n is 0' do
    it 'returns 0' do
      expect(fibonacci(0)).to eq(0)
    end
  end

  context 'when n is 1' do
    it 'returns 1' do
      expect(fibonacci(1)).to eq(1)
    end
  end

  describe 'sequence and answers' do
    sequences = {
      0 => 0, 1 => 1, 2 => 1, 3 => 2, 4 => 3, 5 => 5,
      6 => 8, 7 => 13, 8 => 21, 9 => 34, 10 => 55, 11 => 89,
      12 => 144, 13 => 233, 14 => 377, 15 => 610, 16 => 987,
      17 => 1597, 18 => 2584, 19 => 4181, 20 => 6765
    }

    sequences.each_pair do |n, expected_result|
      it "returns #{expected_result} when n is #{n}" do
        expect(fibonacci(n)).to eq(expected_result)
      end
    end
  end
end
