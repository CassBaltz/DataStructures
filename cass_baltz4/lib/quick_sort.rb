require "byebug"

class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    val = array[0]
    left_array = []
    right_array = []
    array[1..-1].each do |num|
      num <= val ? left_array << num : right_array << num
    end

    QuickSort.sort1(left_array) + [val] + QuickSort.sort1(right_array)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc = prc || Proc.new { |el1, el2| el1 <=> el2 }

    return array if length < 2
    p array
    pivot_idx = QuickSort.partition(array, start, length, &prc)

    left_length = pivot_idx - start
    right_length = length - (left_length + 1)
    QuickSort.sort2!(array, start, left_length, &prc)
    QuickSort.sort2!(array, pivot_idx + 1, right_length, &prc)

    array
  end

  def self.partition(array, start, length, &prc)
    prc = prc || Proc.new { |el1, el2| el1 <=> el2 }
    piv = array[start]
    pivot_idx = start
    i = start + 1
      while i < start + length
        if prc.call(piv, array[i]) == 1
          if (i - pivot_idx) > 1
            val = array[pivot_idx + 1]
            array[pivot_idx] = array[i]
            array[pivot_idx + 1] = piv
            array[i] = val
          else
            array[pivot_idx], array[i] = array[i], piv
          end
          pivot_idx += 1
        end
        i += 1
      end
    pivot_idx
  end
end
