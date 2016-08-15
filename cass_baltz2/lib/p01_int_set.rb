class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = num
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    return false if @store[num] == false
    true
  end

  private

  def is_valid?(num)
    num.between?(0, @store.length - 1)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    @store[@count][0] = num
    @count += 1
  end

  def remove(num)
    @count.times do |i|
      if @store[i][0] == num
        @store[i][0] = []
      end
    end
  end

  def include?(num)
    @count.times do |i|
      if @store[i][0] == num
        return true
      end
    end
    false
  end

  private

  def [](num)
    @store[num]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count == num_buckets - 1
    @store[@count][0] = num
    @count += 1
  end

  def remove(num)
    @count.times do |i|
      if @store[i][0] == num
        @store[i][0] = []
      end
    end
  end

  def include?(num)
    @count.times do |i|
      if @store[i][0] == num
        return true
      end
    end
    false
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
