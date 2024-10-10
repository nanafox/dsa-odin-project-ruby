# frozen_string_literal: true

require 'rspec'
require_relative '../../binary_search_tree/lib/binary_search_tree'

RSpec.describe BinarySearchTree::Node, type: :module do
  let(:data) { 5 }
  let(:node) { described_class.new(data:, left: nil, right: nil) }

  it 'initializes with data, left, and right attributes' do
    expect(node.data).to eq(data)
    expect(node.left).to be_nil
    expect(node.right).to be_nil
  end
end

RSpec.describe BinarySearchTree::Tree do
  let(:data) { [1, 2, 3, 4, 5, 6, 7] }
  let(:tree) { described_class.new(data) }

  describe '#initialize' do
    it 'builds a tree from elements' do
      expect(tree.root.data).to eq(4)
    end

    it 'builds a tree with left and right nodes' do
      expect(tree.root.left.data).to eq(2)
      expect(tree.root.right.data).to eq(6)
    end

    describe 'sub trees' do
      it 'builds the left sub tree' do
        expect(tree.root.left.left.data).to eq(1)
        expect(tree.root.left.right.data).to eq(3)
      end

      it 'builds the right sub tree' do
        expect(tree.root.right.left.data).to eq(5)
        expect(tree.root.right.right.data).to eq(7)
      end
    end

    it 'returns the correct size after initialization' do
      expect(tree.size).to eq(data.size)
    end
  end

  describe '#insert' do
    let(:initial_size) { tree.size }

    before do
      initial_size
    end

    it 'inserts new elements into the tree' do
      tree.insert(8)
      expect(tree.root.right.right.right.data).to eq(8)
    end

    it 'increases the size of the tree' do
      tree.insert(8)
      expect(tree.size).to eq(initial_size + 1)
    end

    context 'when the element to be inserted already exists' do
      before do
        tree.insert(6)
      end
      it 'does not insert the element' do
        expect(tree.size).to eq(initial_size)
      end
    end
  end

  describe '#find' do
    context 'when the tree is empty' do
      it 'returns nil' do
        new_tree = BinarySearchTree::Tree.new([])

        expect(new_tree.find(10)).to be_nil
      end
    end

    context 'when the searched value is the root node' do
      it 'returns the correct data value' do
        expect(tree.find(4)&.data).to eq(4)
      end

      it 'returns the root node of the tree' do
        expect(tree.find(4)).to eq(tree.root)
      end
    end

    context 'when the node exists in the tree' do
      it 'returns the node with the given value' do
        expect(tree.find(4)&.data).to eq(4)
        expect(tree.find(1)&.data).to eq(1)
        expect(tree.find(6)&.data).to eq(6)
      end
    end

    context 'when the node does not exist in the tree' do
      it 'returns nil' do
        expect(tree.find(10)).to be_nil
        expect(tree.find(0)).to be_nil
        expect(tree.find(23)).to be_nil
      end
    end
  end

  describe '#delete' do
    context 'when the tree is empty' do
      it 'returns nil' do
        new_tree = BinarySearchTree::Tree.new([])

        expect(new_tree.delete(10)).to be_nil
      end
    end

    context 'when the node to be deleted is the root node' do
      let(:new_root) { tree.delete(4) }

      it 'deletes the root node and returns the new root' do
        expect(tree.find(4)).not_to be_nil
        expect(new_root).not_to be_nil
        expect(new_root&.data).not_to eq(4)
      end

      it 'sets the root node to new root node' do
        expect(tree.root).to eq(new_root)
      end

      it 'decreases the size of the tree' do
        expect { new_root }.to change(tree, :size).by(-1)
      end

      it 'sets the new root node to the correct value' do
        expect(new_root.data).to eq(5)
      end
    end

    context 'when the node to be deleted has no children' do
      it 'deletes the node and sets the parent link to nil' do
        tree.delete(2)
        expect(tree.find(2)).to be_nil
        expect(tree.root.left.right).to be_nil
      end
    end

    context 'when the node to be deleted has one child' do
      it 'deletes the node and promotes its child' do
        tree.delete(2)

        expect(tree.find(2)).to be_nil
        expect(tree.root.left.data).to eq(3)
      end
    end

    context 'when the node to be deleted has two children' do
      it 'deletes the node and replaces it with its in-order successor' do
        tree.insert(3)
        tree.delete(1)
        expect(tree.find(1)).to be_nil
        expect(tree.root.left.data).to eq(2)
        expect(tree.root.left.right.data).to eq(3)
      end
    end

    context 'when the node to be deleted does not exist in the tree' do
      it 'returns nil and does not modify the tree' do
        expect(tree.delete(1010)).to be_nil
      end
    end
  end

  describe 'traversals' do
    describe '#level_order' do
      context 'when no block is given' do
        it 'returns an array of values in level order' do
          expect(tree.level_order).to eq([4, 2, 6, 1, 3, 5, 7])
        end
      end

      context 'when a block is given' do
        it 'yields each value to the block' do
          values = []
          tree.level_order { |value| values << value }

          expect(values).to eq([4, 2, 6, 1, 3, 5, 7])
        end

        it 'returns only values that match the block' do
          values = []
          tree.level_order { |value| values << value if value >= 4 }

          expect(values).to eq([4, 6, 5, 7])
        end

        context 'when the tree is empty' do
          it 'returns an empty array when no block is given' do
            empty_tree = described_class.new([])
            expect(empty_tree.level_order).to eq([])
          end

          it 'does not yield to the block' do
            empty_tree = described_class.new([])
            values = []
            empty_tree.level_order { |value| values << value }

            expect(values).to be_empty
          end
        end
      end
    end

    describe '#inorder' do
      context 'when the tree is empty' do
        it 'returns an empty array' do
          empty_tree = described_class.new([])
          expect(empty_tree.inorder).to eq([])
        end
      end

      context 'when the tree has nodes' do
        it 'returns an array of values in inorder sequence' do
          p tree.inorder
          expect(tree.inorder).to eq([1, 2, 3, 4, 5, 6, 7])
        end
      end

      context 'when a block is given' do
        it 'yields each value to the block' do
          values = []
          tree.inorder { |value| values << value }

          expect(values).to eq([1, 2, 3, 4, 5, 6, 7])
        end
      end
    end

    describe '#preorder' do
      context 'when the tree is empty' do
        it 'returns an empty array' do
          empty_tree = described_class.new([])
          expect(empty_tree.preorder).to eq([])
        end
      end

      context 'when the tree has nodes' do
        it 'returns an array of values in preorder sequence' do
          expect(tree.preorder).to eq([4, 2, 1, 3, 6, 5, 7])
        end
      end

      context 'when a block is given' do
        it 'yields each value to the block' do
          values = []
          tree.preorder { |value| values << value }

          expect(values).to eq([4, 2, 1, 3, 6, 5, 7])
        end

        it 'returns only the data matches a condition in the block' do
          values = []

          tree.preorder { |value| values << value if value < 4 }
          expect(values).to eq([2, 1, 3])
        end
      end
    end

    describe '#postorder' do
      context 'when the tree is empty' do
        it 'returns an empty array' do
          empty_tree = described_class.new([])
          expect(empty_tree.postorder).to eq([])
        end
      end

      context 'when the tree has nodes' do
        it 'returns an array of values in postorder sequence' do
          expect(tree.postorder).to eq([1, 3, 2, 5, 7, 6, 4])
        end
      end

      context 'when a block is given' do
        it 'yields each value to the block' do
          values = []
          tree.postorder { |value| values << value }

          expect(values).to eq([1, 3, 2, 5, 7, 6, 4])
        end

        it 'returns only the data matches a condition in the block' do
          values = []

          tree.postorder { |value| values << value if value < 4 }
          expect(values).to eq([1, 3, 2])
        end
      end
    end
  end

  describe '#height' do
    context 'when the tree is empty' do
      it 'returns -1' do
        empty_tree = described_class.new([])
        expect(empty_tree.height).to eq(-1)
      end
    end

    context 'when the tree has nodes' do
      it 'returns the height of the tree' do
        puts tree.pretty_print
        expect(tree.height).to eq(2)
      end
    end

    context 'when a sub tree node is passed as the starting node' do
      it 'returns the height of the sub tree' do
        expect(tree.height(tree.root.left)).to eq(1)
      end
    end

    context 'when only the root node exists' do
      it 'returns 0 as the height' do
        expect(described_class.new([1]).height).to eq(0)
      end
    end
  end

  describe '#depth' do
    context 'when the node is at the root' do
      it 'returns 0' do
        expect(tree.depth(tree.root)).to eq(0)
      end
    end

    context 'when the node is not at the root' do
      it 'returns the depth of the node' do
        expect(tree.depth(tree.root.left.right)).to eq(2)
      end
    end

    context 'when the node does not exist in the tree' do
      it 'returns nil or an appropriate value' do
        expect(tree.depth(nil)).to be_nil
      end
    end
  end

  describe '#balanced?' do
    let!(:balanced_tree) { tree }

    context 'when the tree is balanced' do
      it 'returns true' do
        expect(balanced_tree.balanced?).to be true
      end
    end

    context 'when the tree is not balanced' do
      it 'returns false' do
        unbalanced_tree = described_class.new([4, 5, 1])

        # make the tree unbalanced
        unbalanced_tree.insert(2)
        unbalanced_tree.insert(6)
        unbalanced_tree.insert(7)

        expect(unbalanced_tree.balanced?).to be false
      end
    end
  end

  describe '#size' do
    it 'returns the number of nodes in the tree' do
      expect(tree.size).to eq(data.size)
    end

    context 'when the tree is empty' do
      it 'returns 0' do
        empty_tree = described_class.new([])
        expect(empty_tree.size).to eq(0)
      end
    end

    context 'when a node is deleted' do
      it 'decreases the size of the tree' do
        expect(tree.size).to eq(data.size)

        expect { tree.delete(2) }.to change(tree, :size).by(-1)
      end
    end
  end

  describe '#rebalance' do
    context 'when the tree is unbalanced' do
      let(:unbalanced_tree) { described_class.new([4, 5, 1]) }

      before do
        unbalanced_tree.insert(2)
        unbalanced_tree.insert(6)
        unbalanced_tree.insert(7)
      end

      it 'rebalances the tree' do
        expect(unbalanced_tree.balanced?).to be false

        unbalanced_tree.rebalance

        p unbalanced_tree.inorder

        expect(unbalanced_tree.balanced?).to be true
      end

      it 'keeps all original values' do
        original_values = unbalanced_tree.inorder

        unbalanced_tree.rebalance

        expect(unbalanced_tree.inorder).to eq(original_values)
      end
    end

    context 'when the tree is already balanced' do
      let(:balanced_tree) { tree }

      it 'remains balanced after rebalancing' do
        expect(balanced_tree.balanced?).to be true

        balanced_tree.rebalance

        expect(balanced_tree.balanced?).to be true
      end
    end
  end
end
