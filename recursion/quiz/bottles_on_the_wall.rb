# frozen_string_literal: true

# Recursively prints the number of bottles of beer on the wall.
# When the number reaches 0, it prints a message indicating no more bottles.
#
# @param num [Integer] the number of bottles of beer on the wall
def bottles_on_the_wall(num)
  if num <= 0
    puts 'no more bottles of beer on the wall'
    return
  end

  puts "#{num} bottles of beer on the wall"
  bottles_on_the_wall(num - 1)
end
