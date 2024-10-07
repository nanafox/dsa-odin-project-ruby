# frozen_string_literal: true

require_relative '../../hash_map/lib/hash_map'

# rubocop:disable Metrics/BlockLength

RSpec.describe HashMap, type: :class do
  subject(:hash_map) { described_class.new }

  shared_examples 'a hash map with key-value pairs' do
    it 'returns the correct length' do
      expect(hash_map.length).to eq(expected_length)
    end

    it 'returns the correct keys' do
      expect(hash_map.keys).to match_array(expected_keys)
    end

    it 'returns the correct values' do
      expect(hash_map.values).to match_array(expected_values)
    end

    it 'returns the correct entries' do
      expect(hash_map.entries).to match_array(expected_entries)
    end
  end

  describe '#initialize' do
    it 'initializes with the correct size and attributes' do
      expect(hash_map.length).to eq(0)
      expect(hash_map.keys).to be_empty
      expect(hash_map.values).to be_empty
      expect(hash_map.entries).to be_empty
    end
  end

  describe '#set' do
    before do
      hash_map.set('key1', 'value1')
      hash_map.set('key2', 'value2')
    end

    it 'returns the value when adding a new key-value pair' do
      expect(hash_map.set('key3', 'value3')).to eq('value3')
    end

    it 'returns the updated value when updating an existing key' do
      expect(hash_map.set('key1', 'new_value')).to eq('new_value')
    end

    it 'increases the length when adding a new key-value pair' do
      expect { hash_map.set('key3', 'value3') }.to change { hash_map.length }.by(1)
    end

    it 'resizes the hash map when the load factor is exceeded' do
      initial_size = hash_map.instance_variable_get(:@size)
      load_factor = HashMap::LOAD_FACTOR
      (initial_size * load_factor).ceil.times do |i|
        hash_map.set("key#{i}", i)
      end

      new_size = hash_map.instance_variable_get(:@size)
      expect(new_size).to be > initial_size
      expect(hash_map.length).to eq((initial_size * load_factor).ceil)
    end

    it_behaves_like 'a hash map with key-value pairs' do
      let(:expected_length) { 2 }
      let(:expected_keys) { %w[key1 key2] }
      let(:expected_values) { %w[value1 value2] }
      let(:expected_entries) { [%w[key1 value1], %w[key2 value2]] }
    end
  end

  describe '#get' do
    before do
      hash_map.set('key1', 'value1')
      hash_map.set('key2', 'value2')
    end

    it 'retrieves value for an existing key' do
      expect(hash_map.get('key1')).to eq('value1')
    end

    it 'returns nil for a key that does not exist' do
      expect(hash_map.get('unknown_key')).to be_nil
    end

    it 'retrieves the correct value after multiple inserts' do
      hash_map.set('key3', 'value3')
      expect(hash_map.get('key2')).to eq('value2')
    end

    it 'retrieves the updated value after an update' do
      hash_map.set('key1', 'updated_value')
      expect(hash_map.get('key1')).to eq('updated_value')
    end

    it 'handles different data types for values' do
      hash_map.set('key3', 123)
      expect(hash_map.get('key3')).to eq(123)
    end
  end

  describe '#remove' do
    before do
      hash_map.set('key1', 'value1')
      hash_map.set('key2', 'value2')
    end

    it 'removes an existing key-value pair' do
      hash_map.remove('key1')
      expect(hash_map.get('key1')).to be_nil
    end

    it 'returns the value of the removed key' do
      expect(hash_map.remove('key1')).to eq('value1')
    end

    it 'returns nil when trying to remove a key that does not exist' do
      expect(hash_map.remove('unknown_key')).to be_nil
    end

    it 'does not affect other key-value pairs when removing a key' do
      hash_map.remove('key1')
      expect(hash_map.get('key2')).to eq('value2')
    end

    it 'handles different data types for values when removing' do
      hash_map.set('key3', 123)
      hash_map.remove('key3')
      expect(hash_map.get('key3')).to be_nil
    end

    context 'after removing an item' do
      before { hash_map.remove('key1') }

      it_behaves_like 'a hash map with key-value pairs' do
        let(:expected_length) { 1 }
        let(:expected_keys) { ['key2'] }
        let(:expected_values) { ['value2'] }
        let(:expected_entries) { [%w[key2 value2]] }
      end
    end
  end

  describe '#has?' do
    before do
      hash_map.set('key1', 'value1')
    end

    it 'returns true for a key that exists' do
      expect(hash_map.has?('key1')).to be true
    end

    it 'returns false for a key that does not exist' do
      expect(hash_map.has?('unknown_key')).to be false
    end

    it 'returns true for a key after an update' do
      hash_map.set('key1', 'updated_value')
      expect(hash_map.has?('key1')).to be true
    end

    it 'returns false for a key that has been removed' do
      hash_map.remove('key1')
      expect(hash_map.has?('key1')).to be false
    end

    it 'handles different data types for keys' do
      hash_map.set(:symbol_key, 'value1')
      expect(hash_map.has?(:symbol_key)).to be true
    end
  end

  describe '#length' do
    it 'returns 0 for an empty hash map' do
      expect(hash_map.length).to eq(0)
    end

    it 'returns the correct length after adding key-value pairs' do
      hash_map.set('key1', 'value1')
      hash_map.set('key2', 'value2')
      expect(hash_map.length).to eq(2)
    end

    it 'returns the correct length after removing key-value pairs' do
      hash_map.set('key1', 'value1')
      hash_map.set('key2', 'value2')
      hash_map.remove('key1')
      expect(hash_map.length).to eq(1)
    end

    it 'returns the correct length after updating key-value pairs' do
      hash_map.set('key1', 'initial_value')
      hash_map.set('key1', 'updated_value')
      expect(hash_map.length).to eq(1)
    end

    it 'does not change length when updating a value for an existing key' do
      hash_map.set('key1', 'initial_value')
      expect(hash_map.length).to eq(1)
      hash_map.set('key1', 'updated_value')
      expect(hash_map.length).to eq(1)
    end

    it 'handles different data types for keys' do
      hash_map.set(:symbol_key, 'value1')
      hash_map.set(123, 'value2')
      expect(hash_map.length).to eq(2)
    end

    it 'returns the correct length after clearing the hash map' do
      hash_map.set('key1', 'value1')
      hash_map.set('key2', 'value2')
      hash_map.clear
      expect(hash_map.length).to eq(0)
    end
  end

  describe '#keys' do
    before do
      hash_map.set('key1', 'value1')
      hash_map.set('key2', 'value2')
    end

    it 'returns an array of keys' do
      expect(hash_map.keys).to match_array(%w[key1 key2])
    end

    it 'returns an empty array after clearing the hash map' do
      hash_map.clear
      expect(hash_map.keys).to eq([])
    end
  end

  describe '#values' do
    before do
      hash_map.set('key1', 'value1')
      hash_map.set('key2', 'value2')
    end

    it 'returns an array of values' do
      expect(hash_map.values).to match_array(%w[value1 value2])
    end

    it 'returns an empty array after clearing the hash map' do
      hash_map.clear
      expect(hash_map.values).to eq([])
    end
  end

  describe '#clear' do
    before do
      hash_map.set('key1', 'value1')
      hash_map.set('key2', 'value2')
    end

    it 'clears the hash map' do
      hash_map.clear
      expect(hash_map.length).to eq(0)
      expect(hash_map.keys).to be_empty
      expect(hash_map.values).to be_empty
      expect(hash_map.entries).to be_empty
    end
  end

  describe '#entries' do
    before do
      hash_map.set('key1', 'value1')
      hash_map.set('key2', 'value2')
    end

    it 'returns an array of key-value pairs' do
      expect(hash_map.entries).to match_array([%w[key1 value1], %w[key2 value2]])
    end

    it 'returns an empty array after clearing the hash map' do
      hash_map.clear
      expect(hash_map.entries).to eq([])
    end
  end
end

# rubocop:enable Metrics/BlockLength
