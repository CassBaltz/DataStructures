require_relative "heap"
require "byebug"

class Array
  def heap_sort!
    prc = Proc.new { |el1, el2| el1 <=> el2 }
    heap = BinaryMinHeap.new(&prc)

    self.each {|el| heap.push(el)}
    ary = []

    self.length.times do |el|
      ary << heap.extract
    end
    ary.reverse
    ary.length.times do |i|
      self[i] = ary[i]
    end 
  end
end
