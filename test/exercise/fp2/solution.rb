module Exercise
  module Fp2
    class MyArray < Array
      # Использовать стандартные функции массива для решения задач нельзя.
      # Использовать свои написанные функции для реализации следующих - можно.

      # Написать свою функцию my_each
      def my_each
        iter = lambda { |arr|
          return self if arr.empty?

          first, *rest = arr
          yield first
          iter.call(rest)
        }

        iter.call(self)
      end

      # Написать свою функцию my_map
      def my_map(&func)
        iter = ->(acc, element) { acc << func.call(element) }
        MyArray.new(self).my_reduce(MyArray.new, &iter)
      end

      # Написать свою функцию my_compact
      def my_compact
        iter = ->(acc, element) { element.nil? ? acc : acc << element }
        MyArray.new(self).my_reduce(MyArray.new, &iter)
      end

      # Написать свою функцию my_reduce
      def my_reduce(init_acc = nil, &func)
        iter = lambda { |acc, arr|
          return acc if arr.empty?

          first, *rest = arr
          iter.call(func.call(acc, first), rest)
        }
        return iter.call(init_acc, self) unless init_acc.nil?

        head, *tail = self
        iter.call(head, tail)
      end
    end
  end
end
