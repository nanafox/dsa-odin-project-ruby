# frozen_string_literal: true

require_relative '../../knight_moves/lib/knight_moves'

RSpec.describe '#valid_move?' do
  it 'returns true for a valid move' do
    visited = Array.new(8) { Array.new(8, false) }
    expect(valid_move?([0, 0], visited)).to eq(true)
  end

  it 'returns false for an already visited position' do
    visited = Array.new(8) { Array.new(8, false) }
    visited[0][0] = true
    expect(valid_move?([0, 0], visited)).to eq(false)
  end

  it 'returns false for a position outside the board' do
    visited = Array.new(8) { Array.new(8, false) }
    expect(valid_move?([8, 8], visited)).to eq(false)
  end
end
