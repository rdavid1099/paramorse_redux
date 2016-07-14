require './lib/decoder'

module ParaMorse

  class FileDecoder
    attr_reader :encoded_filename,
                :plain_filename
    def initialize
      @decoder = Decoder.new
    end

    def decode(encode, plain)
      @encoded_filename = check_for_txt(encode)
      @plain_filename = check_for_txt(plain)
      file_validated ? write_file : "File does not exist"
    end

    def file_validated
      File.exist?(@encoded_filename)
    end

    def check_for_txt(filename)
      return filename = "./text/#{filename}.txt" unless filename =~ /.txt/
      "./text/#{filename}"
    end

    def encoded_file_contents
      File.read(@encoded_filename)
    end

    def decode_file_contents
      @decoder.decode(encoded_file_contents)
    end

    def write_file
      file = File.new(@plain_filename, 'w')
      file.write(decode_file_contents)
      file.close
    end
  end

end
