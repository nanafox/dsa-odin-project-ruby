#!/usr/bin/env ruby
# frozen_string_literal: true

def collatz(num)
  raise ArgumentError, 'n must be greater than zero' if num <= 0

  return 0 if num == 1

  return 1 + collatz(num / 2) if num.even?

  1 + collatz((3 * num) + 1) if num.odd?
end

number = 10

number.downto(1) do |n|
  steps = collatz(n)
  puts "It took #{steps} steps to go from #{n} to 1."
end
