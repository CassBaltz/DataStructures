require "byebug"

class BinaryMinHeap
  def initialize(&prc)
    @prc = prc
    @store = []
  end

  def count
  end

  def extract
    top = @store[0]
    @store[0] = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, @store.length, &@prc)
    top
  end

  def peek
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, @store.length - 1, @store.length - 1, &@prc)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    first = parent_index * 2 + 1
    second = parent_index * 2 + 2
    last = len - 1

    return [first, second] if (first < last) && (second <= last)
    return [first] if (first == last)
    return [] if (first > last)
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    return (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc = Proc.new {|el1, el2| el1 <=> el2} unless prc
    len ||= array.length

    while BinaryMinHeap.child_indices(len, parent_idx).length == 2

      children = BinaryMinHeap.child_indices(len, parent_idx)

      if prc.call(array[parent_idx], array[children[0]]) == 1 || prc.call(array[parent_idx], array[children[1]]) == 1
        if prc.call(array[children[0]], array[children[1]]) >= 0
          array[children[1]], array[parent_idx] = array[parent_idx], array[children[1]]
          parent_idx = children[1]
        else
          array[children[0]], array[parent_idx] = array[parent_idx], array[children[0]]
          parent_idx = children[0]
        end
      else
        return array
      end
    end

    if BinaryMinHeap.child_indices(len, parent_idx).length == 1
      child = BinaryMinHeap.child_indices(len, parent_idx)[0]
      if prc.call(array[parent_idx], array[child]) == 1
        array[child], array[parent_idx] = array[parent_idx], array[child]
        return array
      end
    end
    return array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc = Proc.new {|el1, el2| el1 <=> el2} unless prc
    while child_idx > 0
      parent_idx = BinaryMinHeap.parent_index(child_idx)
      if prc.call(array[child_idx], array[parent_idx]) == -1
        array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
        child_idx = parent_idx
      else
        return array
      end
    end
    array
  end
end
