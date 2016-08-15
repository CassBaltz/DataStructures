require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    self.store = StaticArray.new(8)
    self.start_idx = 0
    self.length = 0
    self.capacity = 8
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index < 0 || index > self.length - 1
    self.store[check_index(index)]
  end

  # O(1)
  def []=(index, val)
    raise "index out of bounds" if index < 0 || index > self.length - 1
    self.store[check_index(index)] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if self.length <= 0
    self.length -= 1
    self.store[check_index(self.length)]
  end

  # O(1) ammortized
  def push(val)
    self.resize! if self.length == self.capacity
    self.store[check_index(self.length)] = val
    self.length += 1
  end

  # O(1)
  def shift
    val = self[0]
    self.start_idx = (self.start_idx + 1) % self.capacity
    self.length -= 1
    val
  end

  # O(1) ammortized
  def unshift(val)
    self.resize! if self.length == self.capacity
    idx = self.check_index(-1)
    self.store[idx] = val
    self.start_idx = idx
    self.length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    (self.start_idx + index) % self.capacity
  end

  def resize!
    new_capacity = self.capacity * 2
    new_store = StaticArray.new(new_capacity)
    self.length.times {|i| new_store[i] = self[i]}
    self.store = new_store
    self.start_idx = 0
    self.capacity = new_capacity
  end
end
