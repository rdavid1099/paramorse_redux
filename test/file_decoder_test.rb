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
    assert @f('test_encode.txt','test.txt')
  end
end
