# frozen_string_literal: true

require_relative '../../recursion/project/merge_sort'

# rubocop:disable Metrics/BlockLength

RSpec.describe '#merge_sort', type: :method do
  context 'when the list is empty' do
    it 'returns an empty list' do
      expect(merge_sort([])).to eq([])
    end
  end

  context 'when the list contains only one element' do
    it 'returns the arrays with the same element' do
      expect(merge_sort([5])).to eq([5])
    end
  end

  context 'when the array has two or more unsorted numbers' do
    arrays = {
      [2, 1, 3] => [1, 2, 3],
      [5, 3, 8, 6] => [3, 5, 6, 8],
      [10, 2, 7, 1, 5] => [1, 2, 5, 7, 10],
      [4, 2, 9, 7, 3, 6] => [2, 3, 4, 6, 7, 9]
    }

    arrays.each_pair do |unsorted, sorted|
      it "sorts #{unsorted} to become #{sorted}" do
        expect(merge_sort(unsorted)).to eq(sorted)
      end
    end
  end

  context 'when the array contains negative numbers' do
    it 'sorts the array in ascending order' do
      expect(merge_sort([-5, -10, -3, -8, -1])).to eq([-10, -8, -5, -3, -1])
    end
  end

  context 'when the array contains a mix of negative and positive numbers' do
    it 'sorts the array in ascending order' do
      expect(merge_sort([-5, 10, -3, 8, -1])).to eq([-5, -3, -1, 8, 10])
    end
  end

  context 'when a non-array object is passed' do
    it 'raises a TypeError' do
      expect { merge_sort(5) }.to raise_error(TypeError)
    end
  end
end

# rubocop:enable Metrics/BlockLength
