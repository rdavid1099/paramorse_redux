require './lib/encoder'
require './lib/queue'

module ParaMorse

  class StreamEncoder
    attr_reader :current_queue

    def initialize
      @current_queue = Queue.new
    end

    def receive(input)
      @current_queue.push(input)
    end

    def stream_queue
      chars_to_be_encoded = String.new
      until @current_queue.count == 0
        chars_to_be_encoded += @current_queue.pop
      end
      chars_to_be_encoded
    end

    def encode_one_letter
      Encoder.new.encode(@current_queue.pop)
    end

    def encode_entire_stream
      Encoder.new.encode(stream_queue)
    end
  end

end
