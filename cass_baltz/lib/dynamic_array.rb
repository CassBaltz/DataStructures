require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    self.store = StaticArray.new(8)
    self.capacity = 8
    self.length = 0
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index < 0 || index > self.length - 1
    self.store[index]
  end

  # O(1)
  def []=(index, value)
    raise "index out of bounds" if index < 0 || index > self.length
    self.store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if self.length == 0
    self.length -= 1
    self.store[self.length]
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    self.resize! if self.length == self.capacity
    self.store[self.length] = val
    self.length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if self.length == 0
    self.length = self.length - 1
    self.length.times do |i|
      self.store[i] = self.store[i + 1]
    end
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    self.resize! if self.length == self.capacity
    self.length.times do |i|
      self.store[self.length - i ] = self.store[self.length - i - 1]
    end
    self.store[0] = val
    self.length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    self.store = StaticArray.new(self.length * 2)
    self.capacity = self.length * 2
  end
end
