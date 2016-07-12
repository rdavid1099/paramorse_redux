require 'pry'

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
    " " => "0000000",
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

  class Encoder
    def encode(input)
      @input = input
      return LETTERS_TO_MORSE[@input] if @input.length == 1
      letters_to_encode
    end

    def letters_to_encode
      letters_to_morse = @input.split(//).map {|char| encode_chars(char)}
      letters_to_morse.join.chomp('000')
    end

    def encode_chars(char)
      return char + '000' if LETTERS_TO_MORSE.include?(char) == false
      return encode(char).chomp('000') if char == " "
      encode(char) + '000'
    end
  end

  class Decoder
    def decode(input)
      @input = input
      return decode_words if input =~ /0000000/
      return LETTERS_TO_MORSE.key(input) unless input =~ /000/
      input.split('000').map {|letter| decode(letter)}.join
    end

    def decode_words
      decoded_words = @input.split('0000000').map do |word|
        "#{decode(word)} "
      end
      return decoded_words.join.chop
    end
  end

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
  end

  class FileEncoder
    attr_reader :plain_filename,
                :encode_filename

    def initialize
      @encoder = Encoder.new
    end

    def encode(plain, encode)
      @plain_filename = check_for_txt(plain)
      @encode_filename = check_for_txt(encode)
      file_validated ? write_file : "File does not exist"
    end

    def file_validated
      File.exist?(@plain_filename)
    end

    def check_for_txt(filename)
      filename = "#{filename}.txt" unless filename =~ /.txt/
      filename
    end

    def file_to_encode_contents
      File.read(@plain_filename).downcase.chomp
    end

    def encoded_text
      @encoder.encode(file_to_encode_contents)
    end

    def write_file
      file = File.new(@encode_filename, 'w')
      file.write(encoded_text)
      file.close
    end
  end

  class FileDecoder
    
  end
end
