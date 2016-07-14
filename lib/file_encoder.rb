require './lib/encoder'

module ParaMorse

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
      return filename = "./text/#{filename}.txt" unless filename =~ /.txt/
      "./text/#{filename}"
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

end
