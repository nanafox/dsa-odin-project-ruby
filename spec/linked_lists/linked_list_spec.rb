# frozen_string_literal: true

require_relative '../../linked_lists/lib/linked_list'

# rubocop:disable Metrics/BlockLength

RSpec.describe LinkedList, type: :class do
  subject(:list) { described_class.new }

  shared_examples 'a size tester' do |expected_size|
    it "has a size of #{expected_size}" do
      expect(list.size).to eq(expected_size)
    end
  end

  shared_examples 'a list representation' do |representation|
    it "has the representation #{representation}" do
      expect(list.to_s).to eq(representation)
    end
  end

  shared_examples 'head and tail pointer' do |are_equal|
    if are_equal
      it 'head and tail point to the same node' do
        expect(list.head).to eq(list.tail)
      end
    else
      it 'head and tail point to different nodes' do
        expect(list.head).not_to eq(list.tail)
      end
    end
  end

  shared_examples 'a correct node value' do |node, expected_value|
    it "has the correct value for the #{node} node" do
      expect(list.send(node)&.value).to eq(expected_value)
    end
  end

  context 'when the linked list is empty' do
    include_examples 'a size tester', 0
    include_examples 'a list representation', 'nil'
  end

  describe '#append' do
    context 'when adding a single item' do
      before { list.append(2) }

      include_examples 'a size tester', 1
      include_examples 'a list representation', '( 2 ) -> nil'
      include_examples 'head and tail pointer', true
    end

    context 'when two items are in the list' do
      before do
        list.append('dog')
        list.append('cat')
      end

      include_examples 'a size tester', 2
      include_examples 'a list representation', '( dog ) -> ( cat ) -> nil'
      include_examples 'head and tail pointer', false
      include_examples 'a correct node value', :head, 'dog'
      include_examples 'a correct node value', :tail, 'cat'
    end
  end

  describe '#prepend' do
    context 'when adding a single item' do
      before { list.prepend(2) }

      include_examples 'a size tester', 1
      include_examples 'a list representation', '( 2 ) -> nil'
      include_examples 'head and tail pointer', true
    end

    context 'when two items are in the list' do
      before do
        list.prepend('dog')
        list.prepend('cat')
      end

      include_examples 'a size tester', 2
      include_examples 'a list representation', '( cat ) -> ( dog ) -> nil'
      include_examples 'head and tail pointer', false
      include_examples 'a correct node value', :head, 'cat'
      include_examples 'a correct node value', :tail, 'dog'
    end
  end

  describe '#pop' do
    context 'when one item is in the list' do
      before { list.append('dog') }

      it 'removes the item from the list' do
        list.pop
        expect(list.head).to be_nil
      end

      it 'changes the size from 1 to 0' do
        expect { list.pop }.to change(list, :size).from(1).to(0)
      end
    end
  end

  describe '#contains?' do
    before { list.append('cat') }

    context 'when the value is found in the list' do
      it 'returns true' do
        expect(list.contains?('cat')).to eq(true)
      end
    end

    context 'when the value is not found' do
      it 'returns false' do
        expect(list.contains?('blah')).to eq(false)
      end
    end
  end

  describe '#find' do
    before do
      list.append('cat')
      list.prepend('dog')
      list.append('goat')
    end

    context 'when the value is at the beginning of the list' do
      it 'returns the index of the node containing the value' do
        expect(list.find('dog')).to eq(0)
      end
    end

    context 'when the value is in the middle of the list' do
      it 'returns the index of the node containing the value' do
        expect(list.find('cat')).to eq(1)
      end
    end

    context 'when the value is at the end of the list' do
      it 'returns the index of the node containing the value' do
        expect(list.find('goat')).to eq(2)
      end
    end

    context 'when the value is not found' do
      it 'returns nil' do
        expect(list.find('blah')).to eq(nil)
      end
    end
  end

  describe '#at' do
    before do
      list.append('one')
      list.append('two')
      list.append('three')
    end

    it 'returns the correct node for the first index' do
      expect(list.at(0)).to eq(list.head)
    end

    it 'returns the correct node for the last index' do
      expect(list.at(list.size - 1)).to eq(list.tail)
    end

    it 'returns the correct node for an index within the list' do
      expect(list.at(1)).to eq(list.head&.next_node)
    end
  end

  describe '#insert_at' do
    before do
      list.append('dog')
      list.append('cat')
      list.append('goat')
    end

    context 'when using an invalid index' do
      it 'returns nil' do
        expect(list.insert_at(-1, 'rabbit')).to eq(nil)
      end

      it 'does not change the size of the list' do
        expect { list.insert_at(-1, 'rabbit') }.not_to change(list, :size)
      end
    end

    context 'when inserting at the beginning' do
      it 'increases the size by 1' do
        expect { list.insert_at(0, 'rabbit') }.to change(list, :size).by(1)
      end

      it 'correctly inserts the node' do
        list.insert_at(0, 'rabbit')
        expect(list.head&.value).to eq('rabbit')
      end

      it 'has the correct representation' do
        list.insert_at(0, 'rabbit')
        expect(list.to_s).to eq(
          '( rabbit ) -> ( dog ) -> ( cat ) -> ( goat ) -> nil'
        )
      end
    end

    context 'when inserting at the end' do
      it 'increases the size by 1' do
        expect { list.insert_at(list.size, 'rabbit') }.to change(
          list, :size
        ).by(1)
      end

      it 'correctly inserts the node at the end' do
        list.insert_at(list.size, 'rabbit')
        expect(list.tail&.value).to eq('rabbit')
      end

      it 'inserts the node at the end for an out of bounds index' do
        list.insert_at(100, 'rabbit')
        expect(list.tail&.value).to eq('rabbit')
      end
    end

    context 'when inserting in the middle' do
      it 'increases the size by 1' do
        expect { list.insert_at(1, 'rabbit') }.to change(list, :size).by(1)
      end

      it 'sets the new node’s next node correctly' do
        node = list.insert_at(1, 'rabbit')
        expect(node&.next_node&.value).to eq('cat')
      end

      it 'sets the previous node’s next node to the new node' do
        list.insert_at(1, 'rabbit')
        expect(list.head&.next_node&.value).to eq('rabbit')
      end

      it 'has the correct representation' do
        list.insert_at(1, 'rabbit')
        expect(list.to_s).to eq(
          '( dog ) -> ( rabbit ) -> ( cat ) -> ( goat ) -> nil'
        )
      end
    end
  end

  describe '#remove_at' do
    context 'when the list is empty' do
      it 'returns false because nothing was removed' do
        expect(list.remove_at(1)).to eq(false)
      end
    end

    context 'when the list is not empty' do
      before do
        list.append('dog')
        list.append('cat')
        list.append('dog')
      end

      it 'removes the node correctly' do
        index = list.find('cat')
        expect { list.remove_at(index) }.to change { list.size }.by(-1)
        expect(list.contains?('cat')).to be(false)
      end

      it 'returns false for a non-existent node' do
        expect(list.remove_at(100)).to eq(false)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
