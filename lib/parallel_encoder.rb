require './lib/stream_encoder'

module ParaMorse
  class ParallelEncoder
    attr_reader :encoders

    def initialize
      @input_file = String.new
      @encoders = Array.new
    end

    def encode_from_file(input_file, num_of_encoders, output_file)
      @input_file = filename_validator(input_file)
      @output_file = filename_validator(output_file)
      create_encoders(num_of_encoders)
      paramorse_encoder(split_text_into_characters)
    end

    def filename_validator(filename)
      "#{filename}.txt" unless filename.include?('.txt')
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
  end
end
