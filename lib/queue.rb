module ParaMorse

  class Queue
    def initialize
      @queue_frame = Array.new
    end

    def push(data_to_insert)
      @queue_frame << data_to_insert
    end

    def pop
      @queue_frame.shift
    end

    def pop_multiple(number_to_pop)
      @queue_frame.shift(number_to_pop).reverse.join
    end

    def count
      @queue_frame.count
    end

    def tail(number_to_see = -1)
      number_to_see -= (number_to_see * 2) unless number_to_see == -1
      @queue_frame[number_to_see..-1].reverse
    end

    def peek(number_to_see = 1)
      number_to_see -= 1
      @queue_frame[0..number_to_see]
    end

    def clear
      @queue_frame = []
    end
  end
end
