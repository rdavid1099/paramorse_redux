require 'minitest/autorun'
require 'minitest/pride'
require './lib/paramorse'

class TestFileDecoder < Minitest::Test
  def setup
    @f = ParaMorse::FileDecoder.new
  end
  def test_file_decoder_exists
    assert_instance_of ParaMorse::FileDecoder, @f
  end
  def test_file_decoder_finds_files_passed_into_it
    @f.decode('test_encode.txt','test.txt')
    assert_equal 'test_encode.txt', @f.encoded_filename
    assert_equal 'test.txt', @f.plain_filename
  end
  def test_file_decoder_adds_txt_to_filenames
    @f.decode('test_encode','test')
    assert_equal 'test_encode.txt', @f.encoded_filename
    assert_equal 'test.txt', @f.plain_filename
  end
  def test_file_decoder_confirms_encoded_file_existance
    assert_equal "File does not exist", @f.decode('no_file_name', 'test')
  end
  def test_file_decoder_reads_encoded_file
    @f.decode('test_encode', 'test')
    assert_equal '10101010001010000000111010101', @f.encoded_file_contents
  end
  def test_file_decoder_decodes_txt_file
    @f.decode('test_encode', 'test')
    assert_equal 'hi b', @f.decode_file_contents
  end
  def test_file_decoder_saves_decoded_text_to_filename
    @f.decode('test_encode', 'this_test')
    assert_equal 'hi b', File.read('this_test.txt')
  end
  def test_file_decoder_decodes_special_characters
    @f.decode('spec_chars_encoded', 'spec_chars_decode')
  end
end
