# frozen_string_literal: true

# Implements the factorial math function recursively
# This approach does not use memoization for simplicity
def factorial(n)
  return 1 if n <= 1

  n * factorial(n - 1)
end
