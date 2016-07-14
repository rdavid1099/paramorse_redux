require './lib/queue'
require './lib/decoder'

module ParaMorse

  class StreamDecoder
    attr_reader :current_queue

    def initialize
      @current_queue = Queue.new
    end

    def receive(input)
      @current_queue.push(input)
    end

    def decode
      letter_to_be_decoded = String.new
      until @current_queue.count == 0
        letter_to_be_decoded += @current_queue.pop
      end
      Decoder.new.decode(letter_to_be_decoded)
    end

    def decode_letter
      letter_to_be_decoded = @current_queue.pop
      Decoder.new.decoder(letter_to_be_decoded)
    end

    def empty?
      @current_queue.count == 0
    end
  end

end
