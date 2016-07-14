require './lib/stream_decoder'

module ParaMorse
  class ParallelDecoder
    attr_reader :decoders,
                :encoded_files

    def initialize
      @encoded_files = Array.new
      @decoders = Array.new
    end

    def decode_from_files(num_of_decoders, encoded_filename, decoded_filename)
      @decoded_filename = filename_validator(decoded_filename)
      find_encoded_files(num_of_decoders, encoded_filename)
      paramorse_decoder
    end

    def filename_validator(filename)
      return "#{filename}.txt" unless filename.include?('.txt')
      filename
    end

    def find_encoded_files(num_of_files, encoded_filename)
      encoded_filename.chomp!('.txt') if encoded_filename.include?('.txt')
      until @encoded_files.length == num_of_files
        @encoded_files << "#{encoded_filename}#{@encoded_files.length}.txt"
      end
    end

    def file_to_decode_contents(filename)
      File.read(filename)
    end

    def paramorse_decoder
      until @encoded_files.length == 0
        write_to_decoders(@encoded_files.pop)
      end
    end

    def write_to_decoders(filename)
      @decoders << StreamDecoder.new.receive(file_to_decode_contents(filename))
    end

  end

end
