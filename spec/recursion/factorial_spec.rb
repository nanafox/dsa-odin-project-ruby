# frozen_string_literal: true

require 'rspec'
require_relative '../../recursion/quiz/factorial'

RSpec.describe '#factorial' do
  context 'when n is 0' do
    it 'returns 1' do
      expect(factorial(0)).to eq(1)
    end
  end

  context 'with small numbers' do
    let(:expected_answers) { [1, 2, 6, 24, 120] }
    [1, 2, 3, 4, 5].each_with_index do |n, i|
      it "returns the correct answer for #{n}!" do
        expect(factorial(n)).to eq(expected_answers[i])
      end
    end
  end

  context 'when the results are large' do
    let(:expected_answers) { [3_628_800, 479_001_600, 87_178_291_200] }

    [10, 12, 14].each_with_index do |n, i|
      it "returns the correct answer for #{n}!" do
        expect(factorial(n)).to eq(expected_answers[i])
      end
    end
  end
end
