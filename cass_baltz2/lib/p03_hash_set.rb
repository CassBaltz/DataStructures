require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == num_buckets - 1
    @store[@count][0] = key
    @count += 1
  end

  def include?(key)
    @count.times do |i|
      if @store[i][0] == key
        return true
      end
    end
    false
  end

  def remove(key)
    @count.times do |i|
      if @store[i][0] == key
        @store[i][0] = []
      end
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    @store += Array.new(num_buckets) { Array.new }
  end
end
