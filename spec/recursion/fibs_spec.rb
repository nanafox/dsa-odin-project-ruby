# frozen_string_literal: true

require_relative '../../recursion/project/fibs'

RSpec.describe '#fibs', type: :method do
  it 'returns empty array for zero' do
    expect(fibs(0)).to eq([])
  end

  it 'returns single element array for one' do
    expect(fibs(1)).to eq([0])
  end

  it 'returns first two Fibonacci numbers for two' do
    expect(fibs(2)).to eq([0, 1])
  end

  it 'returns Fibonacci sequence for eight' do
    expect(fibs(8)).to eq([0, 1, 1, 2, 3, 5, 8, 13])
  end

  it 'returns Fibonacci sequence for large number' do
    expect(fibs(20)).to eq([0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181])
  end
end
