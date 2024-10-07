# frozen_string_literal: true

require_relative 'hash_map_node'

# Simple linked list implementation for hashmaps
class HashLinkedList
  attr_reader :head, :tail, :size

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(key:, value:)
    node = HashMapNode.new(key:, value:)

    if @head.nil?
      @head = node
    else
      @tail&.next = node
    end
    @tail = node

    @size += 1

    node
  end

  def find(key)
    current = @head

    until current.nil?
      return current if current.key == key

      current = current.next
    end

    nil
  end

  # rubocop:disable Metrics/MethodLength

  def delete(node)
    current = @head

    if current == node
      @head = current&.next
    else
      until current.nil?
        if current.next == node
          current.next = node.next
          break
        end

        current = current.next
      end
    end

    @size -= 1
  end

  # rubocop:enable Metrics/MethodLength
end
