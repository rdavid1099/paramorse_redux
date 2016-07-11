module ParaMorse

  LETTERS_TO_MORSE = {
    "a" => "10111",
    "b" => "111010101",
    "c" => "11101011101",
    "d" => "1110101",
    "e" => "1",
    "f" => "101011101",
    "g" => "111011101",
    "h" => "1010101",
    "i" => "101",
    "j" => "1011101110111",
    "k" => "111010111",
    "l" => "101110101",
    "m" => "1110111",
    "n" => "11101",
    "o" => "11101110111",
    "p" => "10111011101",
    "q" => "1110111010111",
    "r" => "1011101",
    "s" => "10101",
    "t" => "111",
    "u" => "1010111",
    "v" => "101010111",
    "w" => "101110111",
    "x" => "11101010111",
    "y" => "1110101110111",
    "z" => "11101110101",
    " " => "000000",
    "1" => "10111011101110111",
    "2" => "101011101110111",
    "3" => "1010101110111",
    "4" => "10101010111",
    "5" => "101010101",
    "6" => "11101010101",
    "7" => "1110111010101",
    "8" => "111011101110101",
    "9" => "11101110111011101",
    "0" => "1110111011101110111"
  }

  class Queue

    def initialize
      @queue_frame = Array.new
    end

    def push(data_to_insert)
      @queue_frame.unshift(data_to_insert.to_s)
    end

    def pop(number_to_pop = 1)
      @queue_frame.pop(number_to_pop).reverse
    end

    def count
      @queue_frame.count
    end

    def tail(number_to_see = 1)
      @queue_frame[0 .. (number_to_see - 1)]
    end

    def peek(number_to_see = 1)
      @queue_frame[(0 - number_to_see) .. -1].reverse
    end

    def clear
      @queue_frame = []
    end


  end

  class LetterEncoder

    def encode(letter_to_encode)
      LETTERS_TO_MORSE[letter_to_encode]
    end

  end

  class LetterDecoder

    def decode(sequence_to_decode)
      LETTERS_TO_MORSE.key(sequence_to_decode)
    end

  end

  class Encoder

    def initialize
      @letter_encoder = ParaMorse::LetterEncoder.new
      @morse_sequence = []
      @encoded_words = []
    end

    def encode(phrase_to_encode)
      words_to_encode = phrase_to_encode.split

      words_to_encode.each do |word|
        encode_word(word)
      end

      @encoded_words.join("00000")
    end

    def encode_word(word)
      word.each_char do |letter|
        @morse_sequence << @letter_encoder.encode(letter)
      end
      dump_word_into_list
    end

    def dump_word_into_list
      @encoded_words << @morse_sequence.join("000")
      @morse_sequence = []
    end

  end

  class Decoder

    def initialize
      @letter_queue = ParaMorse::Queue.new
      @letter_decoder = ParaMorse::LetterDecoder.new
      @letters_to_decode = []
      @letter_over = false
    end

    def decode(sequence_to_decode)
      split(sequence_to_decode)
      decode_letters.join
    end

    def split(sequence_to_decode)

      sequence_to_decode.each_char do |binary_digit|
        @letter_queue.push(binary_digit)
        determine_end_of_letter

        if @letter_over && @letter_queue.peek == ['0', '0', '0', '0', '0']
          consolidate_into_letter
        elsif @letter_over
          @letter_queue.clear
          @letter_over = false
        end

      end
      @letters_to_decode << consolidate_into_letter

    end

    def determine_end_of_letter
      if @letter_queue.tail(3) == ['0', '0', '0']
        @letters_to_decode << consolidate_into_letter(3)
        @letter_over = true
        # @letter_queue.clear
      end
    end

    def consolidate_into_letter(number_of_dividing_zeros = 0)
      number_to_pop = @letter_queue.count - number_of_dividing_zeros
      @letter_queue.pop(number_to_pop).join
    end

    def decode_letters

      decoded_letters = @letters_to_decode.map do |binary_letter|
        @letter_decoder.decode(binary_letter)
      end

    end
  end




end
