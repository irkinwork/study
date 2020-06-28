module Exercise
  module Arrays
    class << self
      def find_max(arr)
        first, * = arr
        iter = lambda { |coll, max|
          first, *rest = coll
          return max if coll.empty?

          updated_max = first > max ? first : max
          iter.call(rest, updated_max)
        }
        iter.call(arr, first)
      end

      def replace(array)
        max = find_max(array)
        replaced = []
        array.each do |num|
          new_el = num.positive? ? max : num
          replaced.push(new_el)
        end
        replaced
      end

      def find_index(arr, query)
        index = 0
        arr.each do
          return index if arr[index] == query

          index += 1
        end
        nil
      end

      def include?(arr, query)
        arr.each do |el|
          return true if el == query
        end
        false
      end

      def search(array, query)
        return -1 unless include?(array, query)

        iter = proc { |arr|
          half = arr.length / 2
          middle_index = half.integer? ? half : half.round
          middle = arr[middle_index]
          return find_index(array, middle) if middle == query

          new_arr = middle > query ? arr[0, middle_index] : arr[middle_index + 1, arr.length - 1]
          return iter.call(new_arr)
        }
        iter.call(array)
      end
    end
  end
end
