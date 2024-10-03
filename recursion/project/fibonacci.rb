# frozen_string_literal: true

# Calculates the Fibonacci number at a given position.
#
# @param num [Integer] the position in the Fibonacci sequence.
# @return [Integer] the Fibonacci number at the given position.
def fibonacci(num)
  if num.zero?
    0
  elsif num == 1
    1
  else
    fibonacci(num - 1) + fibonacci(num - 2)
  end
end
