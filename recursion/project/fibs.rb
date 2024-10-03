# frozen_string_literal: true

# Returns an array containing the Fibonacci sequence up to the given number
# of elements.
# @param num [Integer] the number of elements in the Fibonacci sequence
# to generate
# @return [Array<Integer>] an array containing the Fibonacci sequence
def fibs(num)
  return [] if num.zero?
  return [0] if num == 1
  return [0, 1] if num == 2

  sequence = [0, 1]

  (num - 2).times do
    sequence << sequence[-1] + sequence[-2]
  end
  sequence
end
