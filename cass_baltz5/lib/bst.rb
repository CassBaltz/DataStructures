require 'byebug'

class BSTNode
  attr_accessor :left, :right
  attr_reader :value

  def initialize(value)
    @left = nil
    @right = nil
    @value = value
  end
end

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value)
    if @root == nil
      @root = BSTNode.new(value)
      return
    end
      BinarySearchTree.insert!(@root, value)
  end

  def find(value)
    BinarySearchTree.find!(@root, value)
  end

  def inorder
    BinarySearchTree.inorder!(@root)
  end

  def postorder

  end

  def preorder

  end

  def height

  end

  def min

  end

  def max

  end

  def delete(value)

  end

  def self.insert!(node, value)
    return BSTNode.new(value) unless node
    if value <= node.value
      if node.left != nil
        self.insert!(node.left, value)
      else
        node.left = BSTNode.new(value)
      end
    else
      if node.right != nil
        self.insert!(node.right, value)
      else
        node.right = BSTNode.new(value)
      end
    end
    node
  end

  def self.find!(node, value)
    return nil unless node
    return node if node.value == value
    if value < node.value
      self.find!(node.left, value)
    else
      self.find!(node.right, value)
    end
  end

  def self.preorder!(node)

  end

  def self.inorder!(node)
    return [] unless node

    arr = []
    arr += BinarySearchTree.inorder!(node.left) if node.left
    arr << node.value
    arr += BinarySearchTree.inorder!(node.right) if node.right

    arr
  end


  def self.postorder!(node)

  end

  def self.height!(node)
    return -1 unless node
    return 0 unless node.left || node.right
    left = 1 + self.height!(node.left)
    right = 1 + self.height!(node.right)

    if left >= right
     left
    else
     right
    end
  end

  def self.max(node)
    until node.right == nil
      node = node.right
    end
    node
  end

  def self.min(node)
    until node.left == nil
      node = node.left
    end
    node
  end

  def self.delete_min!(node)
    return nil unless node
    return node.right if node.left == nil

    node.left = self.delete_min!(node.left)
    node
  end


  def self.delete!(node, value)
    return nil unless node

    if value < node.value
      node.left = self.delete!(node.left, value)
    elsif value > node.value
      node.right = self.delete!(node.right, value)
    else
      return node.left unless node.right
      return node.right unless node.left
      t = node
      node = t.right.min
      node.right = self.delete_min!(t.right)
      node.left = t.left
    end

    node
  end
end
