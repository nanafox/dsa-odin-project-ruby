# frozen_string_literal: true

require_relative '../../knight_moves/lib/knight_moves'

RSpec.describe '#knight_moves' do
  it 'finds the shortest path from [0, 0] to [1, 2]' do
    expect(knight_moves([0, 0], [1, 2])).to eq([[0, 0], [1, 2]])
  end

  it 'finds a valid path from [3, 3] to [4, 3]' do
    result = knight_moves([3, 3], [4, 3])
    expect(result).to include([3, 3])
    expect(result).to include([4, 3])
    expect(result.first).to eq([3, 3])
    expect(result.last).to eq([4, 3])
  end
end
