require './lib/stream_encoder'

module ParaMorse
  class ParallelEncoder
    attr_reader :encoders,
                :output_filenames

    def initialize
      @input_file = String.new
      @encoders = Array.new
      @output_filenames = Array.new
    end

    def encode_from_file(input_file, num_of_encoders, output_file)
      @input_file = filename_validator(input_file)
      create_output_filenames(output_file, num_of_encoders)
      create_encoders(num_of_encoders)
      paramorse_encoder(split_text_into_characters)
      save_paramorse_encoders_to_files
    end

    def filename_validator(filename)
      return "./text/#{filename}.txt" unless filename.include?('.txt')
      "./text/#{filename}"
    end

    def text_in_input_file
      File.read(@input_file)
    end

    def split_text_into_characters
      text_in_input_file.chars
    end

    def create_encoders(num_of_encoders)
      @encoders << ParaMorse::StreamEncoder.new until @encoders.length == num_of_encoders
    end

    def paramorse_encoder(input_characters)
      encoder_counter = 0
      input_characters.each do |char|
        @encoders[encoder_counter].receive(char)
        encoder_counter += 1
        encoder_counter = 0 if encoder_counter == @encoders.length
      end
    end

    def create_output_filenames(filename, num_of_encoders)
      filename.chomp!('.txt') if filename.include?('.txt')
      until @output_filenames.length == num_of_encoders
        @output_filenames << "./text/#{filename}#{@output_filenames.length}.txt"
      end
    end

    def save_paramorse_encoders_to_files
      until @output_filenames.length == 0
        current_output_filename = @output_filenames.pop
        write_file(current_output_filename, @output_filenames.length)
      end
    end

    def write_file(filename, current_encoder)
      file = File.new(filename, 'w')
      file.write(@encoders[current_encoder].encode_entire_stream)
      file.close
    end
  end
end
