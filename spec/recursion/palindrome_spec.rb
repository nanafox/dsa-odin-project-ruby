# frozen_string_literal: true

require_relative '../../recursion/quiz/palindrome'

RSpec.describe '#palindrome', type: :method do
  context 'when the word is not a palindrome' do
    %w[come race eat customize palindrome].each do |word|
      it "returns false when the word is #{word}" do
        expect(palindrome(word)).to be false
      end
    end
  end

  context 'when a single letter word is given' do
    ('a'..'z').each do |letter|
      it "returns true for letter: #{letter}" do
        expect(palindrome(letter)).to be true
      end
    end
  end

  context 'when the word is a palindrome' do
    %w[racecar radar ada].each do |word|
      it "returns true for the word: #{word}" do
        expect(palindrome(word)).to be true
      end
    end

    it 'does not care about the case' do
      expect(palindrome('rAcECaR')).to be true
    end
  end
end
