# frozen_string_literal: true

require_relative '../../recursion/quiz/bottles_on_the_wall'

RSpec.describe '#bottles_on_the_wall', type: :method do
  context "when there's no more bottles left" do
    it 'prints the correct message' do
      expected_output = "no more bottles of beer on the wall\n"

      expect { bottles_on_the_wall(0) }.to output(expected_output).to_stdout
    end
  end

  context "when there's at least one bottle on the wall" do
    it 'prints the expected messages' do
      expected_output = <<~OUTPUT
        1 bottles of beer on the wall
        no more bottles of beer on the wall
      OUTPUT

      expect { bottles_on_the_wall(1) }.to output(expected_output).to_stdout
    end
  end

  context 'when there are two bottles on the wall' do
    expected_output = <<~OUTPUT
      2 bottles of beer on the wall
      1 bottles of beer on the wall
      no more bottles of beer on the wall
    OUTPUT

    it 'prints the correct messages' do
      expect { bottles_on_the_wall(2) }.to output(expected_output).to_stdout
    end
  end
end
