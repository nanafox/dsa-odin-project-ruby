# frozen_string_literal: true

module BinarySearchTree
  # Node class
  class Node
    include Comparable

    # @!attribute data
    #   @return [Object] The data stored in the node
    attr_accessor :data

    # @!attribute left
    #   @return [Node, nil] The left child node
    attr_accessor :left

    # @!attribute right
    #   @return [Node, nil] The right child node
    attr_accessor :right

    # Initializes a new node
    #
    # @param data [Object] The data to be stored in the node
    # @param left [Node, nil] The left child node
    # @param right [Node, nil] The right child node
    def initialize(data:, left: nil, right: nil)
      @data = data
      @left = left
      @right = right
    end

    def ==(other)
      return false unless other.is_a?(Node)

      data == other.data
    end

    def <=>(other)
      return nil unless other.is_a?(Node)

      data <=> other.data
    end

    def >(other)
      return nil unless other.is_a?(Node)

      data > other.data
    end
  end

  # rubocop:disable Metrics/ClassLength

  # Tree class for working with the binary search tree
  class Tree
    include Comparable

    # @!attribute [r] root
    #   @return [Node, nil] The root node of the tree
    attr_reader :root

    # @!attribute [r] size
    #   @return [Integer] The number of nodes in the tree
    #   @note The size of the tree is the number of nodes in the tree
    attr_reader :size

    # Initializes a new binary search tree
    #
    # @param elements [Array<Object>] The elements to build the tree with
    def initialize(elements)
      @size = 0
      @root = build_tree(elements.sort.uniq)
    end

    # Builds a new binary search tree
    #
    # @param elements [Array<Object>] The elements to build the tree with
    # @return [Node, nil] The root node of the tree, or nil if elements are empty
    def build_tree(elements)
      return nil if elements.nil? || elements.empty?

      mid = elements.size / 2
      root = Node.new(data: elements[mid])

      root.left = build_tree(elements[0...mid])
      root.right = build_tree(elements[mid + 1..])

      @size = elements.size
      root
    end

    # Inserts a new node into the binary search tree
    #
    # @note When the element to be inserted already exists in the tree, it
    #  will *not* be inserted.
    #
    # @param data [Object] The data to insert into the tree
    # @param root_node [Node] The current root node
    # @return [Node] The root node after insertion
    def insert(data, root_node: @root)
      if root_node.nil?
        @size += 1
        return Node.new(data:)
      end

      if data < root_node.data
        root_node.left = insert(data, root_node: root_node.left)
      elsif data > root_node.data
        root_node.right = insert(data, root_node: root_node.right)
      end

      root_node
    end

    # Finds a node with the specified data in the binary search tree
    #
    # @param data [Object] The data to find in the tree
    # @param node [Node] The current node to start the search from
    # @return [Node, nil] The node with the specified data, or nil if not found
    def find(data, node = @root)
      return nil if node.nil?

      if data < node.data
        find(data, node.left)
      elsif data > node.data
        find(data, node.right)
      else
        node
      end
    end

    # rubocop:disable Metrics/MethodLength

    # Prints a visual representation of the binary search tree.
    #
    # @param node [Node] The node to start printing from
    # @param prefix [String] The prefix for formatting the tree branches
    # @param is_left [Boolean] Indicates whether the current node is a left child
    # @return [nil]
    def pretty_print(node: @root, prefix: '', is_left: true)
      if node.right
        pretty_print(
          node: node.right,
          prefix: "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false
        )
      end

      puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
      return unless node.left

      pretty_print(
        node: node.left,
        prefix: "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true
      )
    end

    # Deletes a node with the specified value from the binary search tree
    #
    # @param value [Object] The value of the node to be deleted
    # @param root [Node] The root node of the tree or subtree to perform
    # the deletion
    # @return [Node, nil] The new root node of the tree or subtree after
    # deletion, or nil if tree is empty
    def delete(value, root = @root)
      node = remove_node(value, root)

      return nil if node.nil?

      @size -= 1
      @root = node if root == @root

      node
    end

    # rubocop:enable Metrics/MethodLength

    ##
    # Traverses the binary search tree in level order (breadth-first) yielding
    # each node to the provided block.
    #
    # @yield [Node] Yields each node to the provided block if block is given
    # @return [Array] An array of node values in level order if no block is
    # given
    #
    def level_order
      return [] if @root.nil?

      result = []

      traverse_level_order do |data|
        if block_given?
          yield(data)
        else
          result << data
        end
      end

      result
    end

    ##
    # Performs preorder traversal of the binary search tree.
    #
    # @param current_node [Node] The current node to start the traversal from
    # @param result [Array] The array to store the traversal result
    # @yieldparam node_data [Object] Yields the data of each node to
    # the provided block
    # @return [Array] An array of node values in preorder if no block is given
    def preorder(current_node = @root, result = [], &block)
      return [] if current_node.nil?

      if block_given?
        yield(current_node.data)
      else
        result << current_node.data
      end

      preorder(current_node.left, result, &block)
      preorder(current_node.right, result, &block)

      result
    end

    # Performs postorder traversal of the binary search tree.
    #
    # @param current_node [Node] The current node to start the traversal from
    # @param result [Array] The array to store the traversal result
    # @yieldparam node_data [Object] Yields the data of each node to
    # the provided block
    # @return [Array] An array of node values in postorder if no block is given
    def inorder(current_node = @root, result = [], &block)
      return [] if current_node.nil?

      inorder(current_node.left, result, &block)

      if block_given?
        yield(current_node.data)
      else
        result << current_node.data
      end

      inorder(current_node.right, result, &block)

      result
    end

    # Performs postorder traversal of the binary search tree.
    #
    # @param current_node [Node] The current node to start the traversal from
    # @param result [Array] The array to store the traversal result
    # @yieldparam node_data [Object] Yields the data of each node to
    # the provided block
    # @return [Array] An array of node values in postorder if no block is given
    def postorder(current_node = @root, result = [], &block)
      return [] if current_node.nil?

      postorder(current_node.left, result, &block)
      postorder(current_node.right, result, &block)

      if block_given?
        yield(current_node.data)
      else
        result << current_node.data
      end

      result
    end

    # Calculates the height of the binary search tree
    #
    # @param node [Node, nil] The node to start the calculation from
    # @return [Integer] The height of the tree, -1 if the node is nil
    def height(node = @root)
      return -1 if node.nil?

      1 + [height(node.left), height(node.right)].max
    end

    # Calculates the depth of a given node in the binary search tree
    #
    # @param node [Node, nil] The node to find the depth for
    # @param current_node [Node, nil] The current node to start the search from
    # @param depth [Integer] The current depth of the tree
    # @return [Integer, nil] The depth of the given node, or nil if node is not found
    def depth(node = @root, current_node = @root, depth = 0)
      return nil if current_node.nil? || node.nil?
      return depth if current_node == node

      depth += 1
      return depth if current_node == node

      if node < current_node
        depth(node, current_node&.left, depth)
      else
        depth(node, current_node&.right, depth)
      end
    end

    def ==(other)
      return false unless other.is_a?(Tree)

      level_order == other.level_order
    end

    def <=>(other)
      return nil unless other.is_a?(Tree)

      level_order <=> other.level_order
    end

    def balanced?(node = @root)
      return true if node.nil?

      left_height = height(node.left)
      right_height = height(node.right)

      # Check the balance condition for the current node
      if (left_height - right_height).abs <= 1
        # Recursively check the balance of the left and right subtrees
        balanced?(node.left) && balanced?(node.right)
      else
        false
      end
    end

    # Rebalances the binary search tree
    #
    # @return [Tree] The rebalanced tree
    def rebalance
      return self if balanced?

      @root = build_tree(inorder)

      self
    end

    private

      def remove_node(value, root = @root)
        return nil unless traversable?(value:)

        if root.data > value
          root.left = remove_node(value, root.left)
        elsif root.data < value
          root.right = remove_node(value, root.right)
        else
          return single_child_or_nil(root)
        end

        root
      end

      def single_child_or_nil(node)
        return node.right if node.left.nil?
        return node.left if node.right.nil?

        successor_node = successor_for_node(node)
        node.data = successor_node.data
        node.right = remove_node(successor_node.data, node.right)

        node
      end

      # Traverses the binary search tree in level order, yielding each
      # node's data to the provided block.
      #
      # @yield [Object] Yields the data of each node to the provided block
      # @return [Array] An array of node values in level order if no block
      # is given
      def traverse_level_order
        queue = [@root]
        result = []

        until queue.empty?
          node = queue.shift
          yield(node.data) if node

          enqueue_children(queue, node)
        end

        result
      end

      # Helper method to enqueue the left and right children of a given node
      #
      # @param queue [Array] The queue to add the children to
      # @param node [Node] The node whose children will be enqueued
      def enqueue_children(queue, node)
        queue << node.left if node&.left
        queue << node.right if node&.right
      end

      # Finds the successor node of a given node
      #
      # @param node [Node] The node to find the successor for
      # @return [Node] The successor node
      def successor_for_node(node)
        current = node.right

        current = current.left while current&.left

        current || nil
      end

      # Checks if the tree is traversable
      #
      # @param value [Object, nil] The node value to check for traversability
      # @return [Boolean] Returns true if the tree is traversable, false otherwise
      def traversable?(value: nil)
        return false if @root.nil?

        return false if value && !find(value)

        true
      end
  end

  # rubocop:enable Metrics/ClassLength
end
