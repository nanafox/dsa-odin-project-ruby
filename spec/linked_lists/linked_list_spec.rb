# frozen_string_literal: true

require_relative '../../linked_lists/lib/linked_list'

# rubocop:disable Metrics/BlockLength

RSpec.describe 'LinkedList' do
  subject(:list) { LinkedList.new }

  context 'when the linked list is empty' do
    it 'returns the correct representation' do
      expect(list.to_s).to eq('nil')
    end

    it 'has a size of 0' do
      expect(list.size).to eq(0)
    end
  end

  describe '#append' do
    context 'when adding a single item' do
      before do
        list.append(2)
      end

      it 'adds a new node to the end of the list' do
        expect(list.to_s).to eq('( 2 ) -> nil')
      end

      it 'has a size of 1' do
        expect(list.size).to eq(1)
      end

      it 'should have the head and tail pointing to the same node' do
        expect(list.head).to eq(list.tail)
      end
    end

    context 'when two items are in the list' do
      let(:expected_representation) { '( dog ) -> ( cat ) -> nil' }

      before do
        list.append('dog')
        list.append('cat')
      end

      it 'has the correct size' do
        expect(list.size).to eq(2)
      end

      it 'has the correct output representation' do
        expect(list.to_s).to eq(expected_representation)
      end

      it 'should point the head and tail to different objects' do
        expect(list.head).not_to eq(list.tail)
      end

      it 'has the correct value for the head node' do
        expect(list.head&.value).to eq('dog')
      end

      it 'has the correct value fot the tail node' do
        expect(list.tail&.value).to eq('cat')
      end
    end
  end

  describe '#prepend' do
    context 'when adding a single item' do
      before do
        list.prepend(2)
      end

      it 'adds a new node to the beginning of the list' do
        expect(list.to_s).to eq('( 2 ) -> nil')
      end

      it 'has a size of 1' do
        expect(list.size).to eq(1)
      end

      it 'should have the head and tail pointing to the same node' do
        expect(list.head).to eq(list.tail)
      end
    end

    context 'when two items are in the list' do
      let(:expected_representation) { '( cat ) -> ( dog ) -> nil' }

      before do
        list.prepend('dog')
        list.prepend('cat')
      end

      it 'has the correct size' do
        expect(list.size).to eq(2)
      end

      it 'has the correct output representation' do
        expect(list.to_s).to eq(expected_representation)
      end

      it 'should point the head and tail to different objects' do
        expect(list.head).not_to eq(list.tail)
      end

      it 'has the correct value for the head node' do
        expect(list.head&.value).to eq('cat')
      end

      it 'has the correct value fot the tail node' do
        expect(list.tail&.value).to eq('dog')
      end
    end
  end

  describe '#pop' do
    context 'when one item is in the list' do
      before do
        list.append('dog')
      end

      it 'removes the item from the list' do
        list.pop

        expect(list.head).to eq(nil)
        expect(list.tail).to eq(nil)
      end

      it 'changes the size from 1 to 0' do
        expect { list.pop }.to change(list, :size).from(1).to(0)
      end
    end
  end

  describe '#contains?' do
    before do
      list.append('cat')
    end

    context 'when the value is found in the list' do
      it 'return true' do
        expect(list.contains?('cat')).to eq(true)
      end
    end

    context 'when the item is not found' do
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

    context 'when the value is found end the beginning of the list' do
      it 'return the index of the node containing the value' do
        expect(list.find('dog')).to eq(0)
      end
    end

    context 'when the value is found end the middle of the list' do
      it 'return the index of the node containing the value' do
        expect(list.find('cat')).to eq(1)
      end
    end

    context 'when the value is found at the end of the list' do
      it 'return the index of the node containing the value' do
        expect(list.find('goat')).to eq(2)
      end
    end

    context 'when the item is not found' do
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

    it 'returns the correct node for first index' do
      expect(list.at(0)).to eq(list.head)
    end

    it 'returns the correct node for last index' do
      expect(list.at(list.size - 1)).to eq(list.tail)
    end

    it 'returns the correct node for index within the list' do
      expect(list.at(1)).to eq(list.head&.next_node)
    end
  end

  describe '#insert_at' do
    before do
      list.append('dog')
      list.append('cat')
      list.append('goat')
    end

    let(:initial_size) { list.size }

    context 'when a negative index is given' do
      it 'returns nil because the index is invalid' do
        expect(list.insert_at(-1, 'rabbit')).to eq(nil)
      end

      it 'does not change the size of the list' do
        expect { list.insert_at(-1, 'rabbit') }.not_to change(list, :size)
      end
    end

    context 'when inserting at index 0: beginning of the list' do
      subject(:node) { list.insert_at(0, 'rabbit') }
      let(:expected_representation) do
        '( rabbit ) -> ( dog ) -> ( cat ) -> ( goat ) -> nil'
      end

      it 'changes the size of the current list' do
        expect { node }.to change(list, :size).from(3).to(4)
      end

      it 'correctly inserts and returns the node' do
        node # create the node
        expect(list.head).to eq(node)
      end

      it 'has the correct representation' do
        node
        expect(list.to_s).to eq(expected_representation)
      end
    end

    context 'when insertion is done at the end of the list' do
      subject(:node) { list.insert_at(list.size - 1, 'rabbit') }
      let(:expected_representation) do
        '( dog ) -> ( cat ) -> ( goat ) -> ( rabbit ) -> nil'
      end

      it 'inserts the node at the end of the list' do
        node

        expect(list.tail).to eq(node)
      end

      it 'has the correct representation' do
        node
        expect(list.to_s).to eq(expected_representation)
      end

      it 'has its next node set to nil' do
        node

        expect(list.tail&.next_node).to eq(nil)
      end
    end

    describe 'insertion at a particular index in the list' do
      context 'when inserted between "dog" and "cat"' do
        let(:node) { list.insert_at(1, 'rabbit') }
        let(:expected_representation) do
          '( dog ) -> ( rabbit ) -> ( cat ) -> ( goat ) -> nil'
        end

        it 'changes the size of the list by 1' do
          expect { node }.to change { list.size }.from(initial_size)
                                                 .to(initial_size + 1)
        end

        it 'sets the next to the node with value "cat"' do
          expect(node.next_node&.value).to eq('cat')
        end

        it 'sets the next node of the head node to the new node' do
          node
          expect(list.head&.next_node).to eq(node)
        end

        it 'has the correct representation' do
          node
          expect(list.to_s).to eq(expected_representation)
        end
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

      let(:cat_index) { list.find('cat') }
      let(:cat_response) { list.remove_at(cat_index) }

      context 'when the "cat" node is removed' do
        it 'reduces the size of the list by 1' do
          expect { cat_response }.to change { list.size }.from(3).to(2)
        end

        it 'returns true for successful removal' do
          expect(cat_response).to be(true)
        end

        it 'sets the next node of previous to the node after "cat"' do
          cat_response
          expect(list.head&.next_node&.value).to eq('dog')
        end

        it 'fails to find "cat" in the list after it is deleted' do
          cat_response

          expect(list.find('cat')).to be(nil)
          expect(list.contains?('cat')).to be(false)
        end
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
