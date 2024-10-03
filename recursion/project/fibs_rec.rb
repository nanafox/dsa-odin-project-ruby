# frozen_string_literal: true

# Calculates the Fibonacci sequence up to a given number of elements.
#
# @param num [Integer] the number of elements in the Fibonacci sequence.
# @return [Array<Integer>] the Fibonacci sequence up to the given number
# of elements.
def fibs_rec(num)
  return [] if num.zero?
  return [0] if num == 1
  return [0, 1] if num == 2

  sequence = fibs_rec(num - 1)
  sequence << sequence[-1] + sequence[-2]
end
