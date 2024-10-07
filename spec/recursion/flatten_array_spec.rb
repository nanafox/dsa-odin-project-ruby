# frozen_string_literal: true

require_relative '../../recursion/quiz/flatten_array'

# rubocop:disable Metrics/BlockLength

RSpec.describe '#flatten_array!', type: :method do
  context 'when the array is empty' do
    it 'returns an empty array' do
      expect(flatten_array!([])).to eq([])
    end
  end

  context 'when the array is already flattened' do
    it 'returns the same array untouched' do
      expect(flatten_array!([1, 2, 3, 4])).to eq([1, 2, 3, 4])
    end
  end

  context 'when the array contains single nested arrays' do
    array = [[1, 2], [3, 4]]
    expected_outcome = [1, 2, 3, 4]

    it "expects #{array} to become #{expected_outcome}" do
      expect(flatten_array!(array)).to eq(expected_outcome)
    end
  end

  describe 'arrays with nested and non-nested values' do
    array = [[1, [8, 9]], [3, 4], 2, 5]
    expected_outcome = [1, 8, 9, 3, 4, 2, 5]

    it "expects #{array} to become #{expected_outcome}" do
      expect(flatten_array!(array)).to eq(expected_outcome)
    end
  end

  describe 'deeply nested arrays' do
    array = [[[1, 2], 3], [[4], 5, [6, [7, 8]]], 9, [10]]
    expected_outcome = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    it "expects #{array} to become #{expected_outcome}" do
      expect(flatten_array!(array)).to eq(expected_outcome)
    end
  end

  describe 'error handling' do
    it 'throws an ArgumentError for non-array parameters' do
      expect do
        flatten_array!('hello world')
      end.to raise_error(ArgumentError)
    end
  end
end

# rubocop:enable Metrics/BlockLength
