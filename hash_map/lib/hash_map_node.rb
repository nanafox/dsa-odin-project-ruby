# frozen_string_literal: true

# Node class for hashmaps
class HashMapNode
  attr_accessor :key, :value, :next

  def initialize(key:, value:)
    @key = key
    @value = value
    @next = nil
  end

  def to_s
    "Node with key: #{@key} and value: #{@value}"
  end
end
