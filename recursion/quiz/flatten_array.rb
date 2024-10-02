# frozen_string_literal: true

def flatten_array!(arr)
  raise ArgumentError, 'Only arrays are allowed' unless arr.is_a? Array

  return [] if arr.empty?

  arr.each_with_index do |item, index|
    next unless item.is_a? Array

    arr_data = arr.delete_at(index)

    arr_data.each_with_index { |x, i| arr.insert(index + i, x) }

    flatten_array!(arr)
  end
end
