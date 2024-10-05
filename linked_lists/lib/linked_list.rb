# frozen_string_literal: true

require_relative 'node'

# rubocop:disable Metrics/ClassLength

# LinkedList class represents a singly linked list data structure.
class LinkedList
  attr_reader :size

  # Initializes a new LinkedList.
  # Sets the current head and tail of the list to nil.
  # @current_head [Node, nil] the head node of the linked list, initially nil.
  # @current_tail [Node, nil] the tail node of the linked list, initially nil.
  def initialize
    @current_head = nil
    @current_tail = nil
    @size = 0
  end

  # Checks if the given node is the head of the list.
  # @param node [Node] the node to check.
  # @return [Boolean] true if the node is the head, false otherwise.
  def head?(node)
    head == node
  end

  # Checks if the given node is the tail of the list.
  # @param node [Node] the node to check.
  # @return [Boolean] true if the node is the tail, false otherwise.
  def tail?(node)
    tail == node
  end

  # Appends a new node with the given value to the end of the list.
  # @param value [Object] the value to append.
  # @return [Node] the newly appended node.
  def append(value)
    node = Node.new
    node.value = value

    if head.nil?
      @current_head = node
    else
      @current_tail&.next_node = node
    end

    @current_tail = node
    @size += 1

    node
  end

  # Prepends a new node with the given value to the beginning of the list.
  # @param value [Object] the value to prepend.
  # @return [Node] the newly prepended node.
  def prepend(value)
    node = Node.new(value)

    if head.nil?
      @current_tail = node
    else
      node.next_node = head
    end

    @current_head = node
    @size += 1

    node
  end

  # Returns the head node in the list.
  # @return [Node, nil] the head node, or nil if the list is empty.
  def head
    @current_head
  end

  # Returns the tail node in the list.
  # @return [Node, nil] the tail node, or nil if the list is empty.
  def tail
    @current_tail
  end

  # Removes the last node from the list.
  # @return [void]
  def pop
    return if size.zero?

    temp_head = head

    while temp_head&.next_node
      prev_node = temp_head
      temp_head = temp_head.next_node
    end

    prev_node&.next_node = nil
    @current_tail = prev_node
    @size -= 1

    handle_empty_list
  end

  # Checks if the list contains a node with the given value.
  # @param value [Object] the value to check.
  # @return [Boolean] true if the value is found, false otherwise.
  def contains?(value)
    if find(value)
      true
    else
      false
    end
  end

  # Finds the index of the node with the given value.
  # @param value [Object] the value to find.
  # @return [Integer, nil] the index of the node, or nil if not found.
  def find(value)
    return nil if head.nil?

    current = head
    index = 0

    while current
      return index if current.value == value

      index += 1
      current = current.next_node
    end

    nil
  end

  # Converts the linked list to a string representation.
  # @return [String] the string representation of the linked list.
  def to_s
    return 'nil' if size.zero?

    rep = String.new
    temp_head = head

    while temp_head
      rep << "( #{temp_head.value} ) -> "
      temp_head = temp_head.next_node
    end

    rep << 'nil'
  end

  # rubocop:disable Metrics/MethodLength

  # Returns the node at the given index.
  # @param index [Integer] the index of the node to retrieve.
  # @return [Node, nil] the node at the given index, or nil if the
  #   index is out of bounds.
  def at(index)
    return nil if head.nil? || index >= size

    if index.zero?
      return head
    elsif index == size - 1
      tail
    end

    current = head
    current_index = 0

    while current
      return current if current_index == index

      current_index += 1
      current = current.next_node
    end

    nil
  end

  # Removes the node at the specified index.
  # @param index [Integer] the index of the node to remove.
  # @return [Boolean] true if the node was removed, false otherwise.
  def remove_at(index)
    return false if index >= size || !index.positive?

    current_index = 0
    temp_head = head

    while current_index != index
      prev_node = temp_head
      temp_head = temp_head&.next_node
      current_index += 1
    end

    prev_node&.next_node = prev_node&.next_node&.next_node
    @size -= 1

    true
  end

  # rubocop:enable Metrics/MethodLength

  # Inserts a new node with the given value at the specified index.
  #
  # @note For an index that is greater than the size of the list, the new node
  #   is appended. Negative indices are not supported.
  #
  # @param index [Integer] the index at which to insert the new node.
  # @param value [Object] the value of the new node.
  # @return [Node, nil] the newly inserted node or nil if the index is invalid.
  def insert_at(index, value)
    return nil if index.negative?

    return prepend(value) if index.zero?
    return append(value) if index == size - 1 || index >= size

    node = Node.new(value, at(index))
    prev_node = at(index - 1) || head
    prev_node.next_node = node

    @size += 1

    node
  end

  private

    # Handles the case when the list becomes empty.
    # @return [void]
    def handle_empty_list
      return unless size.zero?

      @current_tail = nil
      @current_head = nil
    end
end

# rubocop:enable Metrics/ClassLength
