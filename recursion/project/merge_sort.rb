# frozen_string_literal: true

# Sorts an array using the merge sort algorithm.
#
# @param array [Array<Integer>] the array to be sorted
# @return [Array<Integer>] the sorted array
def merge_sort(array)
  raise TypeError, "Expected Array, got #{array.class}" unless array.is_a?(Array)

  return [] if array.empty?
  return array if array.length <= 1

  mid = array.length / 2
  left = merge_sort(array[0...mid])
  right = merge_sort(array[mid...array.length])
  merge(left, right)
end

# Merges two sorted arrays into a single sorted array.
#
# @param left [Array] the left sorted array
# @param right [Array] the right sorted array
# @return [Array] the merged sorted array
def merge(left, right)
  left ||= []
  right ||= []
  sorted_array = []

  until left.empty? || right.empty?
    sorted_array << if left.first <= right.first
                      left.shift
                    else
                      right.shift
                    end
  end

  sorted_array + left + right
end
