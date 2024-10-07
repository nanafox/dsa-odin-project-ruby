# frozen_string_literal: true

require_relative 'hash_linked_list'

# Hashmap class
class HashMap
  INITIAL_SIZE = 16
  LOAD_FACTOR = 0.75

  attr_reader :length, :keys, :values

  def initialize
    @size = INITIAL_SIZE
    @buckets = Array.new(@size) { HashLinkedList.new }
    @length = 0
    @keys = []
    @values = []
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.to_s.each_char do |char|
      hash_code = prime_number * hash_code + char.ord
    end

    hash_code
  end

  def index_for(key)
    hash(key) % size
  end

  # rubocop:disable Metrics/MethodLength

  def set(key, value)
    index = index_for(key)

    node = @buckets[index].find(key)

    if node
      # avoid stale values
      @values.delete(node.value)

      node.value = value
    else
      @buckets[index].append(key:, value:)
      @length += 1
    end

    update_keys_and_values(key, value)
    resize_if_needed

    value
  end

  # rubocop:enable Metrics/MethodLength

  def get(key)
    index = index_for(key)

    node = @buckets[index].find(key)

    return nil unless node

    node.value
  end

  def remove(key)
    index = index_for(key)
    node = @buckets[index].find(key)

    return nil unless node

    @buckets[index].delete(node)
    @length -= 1

    @keys.delete(key)
    @values.delete(node.value)

    node.value
  end

  def has?(key)
    index = index_for(key)
    node = @buckets[index].find(key)

    !node.nil?
  end

  def clear
    @buckets = Array.new(@size) { HashLinkedList.new }
    @length = 0
    @keys.clear
    @values.clear
  end

  def entries
    @keys.map { |key| [key, get(key)] }
  end

  private

    attr_accessor :size, :buckets

    def update_keys_and_values(key, value)
      @keys << key unless @keys.include?(key)
      @values << value unless @values.include?(value)
    end

    # rubocop:disable Metrics/MethodLength

    def resize_if_needed
      return unless @length >= (@size * LOAD_FACTOR).ceil

      puts "Resizing hashmap from #{@size} to #{@size * 2}"

      new_size = @size * 2
      new_buckets = Array.new(new_size) { HashLinkedList.new }

      @keys.each do |key|
        value = get(key)
        new_index = hash(key) % new_size
        new_buckets[new_index].append(key:, value:)
      end

      @size = new_size
      @buckets = new_buckets
    end

  # rubocop:enable Metrics/MethodLength
end
