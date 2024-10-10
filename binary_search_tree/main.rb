# frozen_string_literal: true

require_relative 'lib/binary_search_tree'

data = [4, 5, 1]

tree = BinarySearchTree::Tree.new(data)

tree.pretty_print
tree.insert(2)
tree.insert(6)

tree.pretty_print

# the tree is unbalanced after this insert
tree.insert(7)
puts tree.balanced?

# insert one more and rebalance
tree.insert(3)

tree.rebalance
tree.pretty_print

puts tree.balanced?

# ensure the inorder still returns the correct order
puts "InOrder: #{tree.inorder}"

# ensure the preorder still returns the correct order
puts "PreOrder: #{tree.preorder}"

# ensure the postorder still returns the correct order
puts "PostOrder: #{tree.postorder}"

# ensure the level_order still returns the correct order
puts "LevelOrder: #{tree.level_order}"
