# frozen_string_literal: true

require_relative '../../knight_moves/lib/knight_moves'

RSpec.describe '#generate_possible_moves' do
  it 'generates possible moves for position [0, 0]' do
    expect(generate_possible_moves([0, 0])).to match_array([[2, 1], [1, 2]])
  end

  it 'generates possible moves for position [3, 3]' do
    expected_moves = [
      [5, 4], [4, 5], [2, 5], [1, 4],
      [1, 2], [2, 1], [5, 2], [4, 1]
    ]
    expect(generate_possible_moves([3, 3])).to match_array(expected_moves)
  end
end
