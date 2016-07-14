require './lib/stream_decoder'
require './lib/queue'
require 'pry'

module ParaMorse
  class ParallelDecoder
    attr_reader :decoders,
                :encoded_files

    def initialize
      @encoded_files = Array.new
      @decoders = Array.new
      @queue = Queue.new
    end

    def decode_from_files(num_of_decoders, encoded_filename, decoded_filename)
      @decoded_filename = filename_validator(decoded_filename)
      find_encoded_files(num_of_decoders, encoded_filename)
      paramorse_decoder
      write_decoded_content_to_file
    end

    def filename_validator(filename)
      return "./text/#{filename}.txt" unless filename.include?('.txt')
      "./text/#{filename}"
    end

    def find_encoded_files(num_of_files, encoded_filename)
      encoded_filename.chomp!('.txt') if encoded_filename.include?('.txt')
      until @encoded_files.length == num_of_files
        @encoded_files << "./text/#{encoded_filename}#{@encoded_files.length}.txt"
      end
    end

    def file_to_decode_contents(filename)
      File.read(filename).chars
    end

    def paramorse_decoder
      until @encoded_files.length == 0
        write_to_decoders(@encoded_files.pop)
      end
    end

    def write_to_decoders(filename)
      stream = StreamDecoder.new
      split_up_letters(filename)
      until @queue.count == 0
        stream.receive(@queue.pop)
      end
      @decoders << stream
    end

    def split_up_letters(filename)
      complete_chars = String.new
      contents = file_to_decode_contents(filename)
      contents.each.with_index do |digit, i|
        complete_chars += digit
        if complete_chars.include?('000') && contents[i + 1] != '0'
          @queue.push(complete_chars)
          complete_chars = ""
        elsif contents[i + 1] == nil
          @queue.push(complete_chars)
          complete_chars = ""
        end
      end
    end

    def combine_parallel_decoders
      content = String.new
      @decoders.reverse!
      counter = 0
      until @decoders.length == 0
        counter = 0 if counter > @decoders.length - 1
        content += @decoders[counter].decode_letter unless @decoders[counter].empty?
        if @decoders[counter].empty?
          @decoders.slice!(counter)
        else
          counter += 1
        end
      end
      content
    end

    def write_decoded_content_to_file
      decoded_content = combine_parallel_decoders
      file = File.new(@decoded_filename, 'w')
      file.write(decoded_content)
      file.close
    end
  end
end
