require 'minitest/autorun'
require 'minitest/pride'
require './lib/parallel_decoder'

class TestParallelDecoder < Minitest::Test
  def setup
    @p = ParaMorse::ParallelDecoder.new
  end
  def test_parallel_decoder_exists
    assert_instance_of ParaMorse::ParallelDecoder, @p
  end
  def test_parallel_decoder_has_decode_from_file_method
    assert_respond_to @p, :decode_from_files
  end
  def test_decode_from_files_can_take_arguments
    @p.decode_from_files(3, 'simple_test_encoder.txt', 'decoded_test.txt')
  end
  def test_decode_from_files_validates_decoded_filename
    assert_equal 'decoded_test.txt', @p.filename_validator('decoded_test')
    assert_equal 'decoded_test.txt', @p.filename_validator('decoded_test.txt')
  end
  def test_decode_from_files_finds_files_to_decode
    @p.decode_from_files(3, 'simple_test_encoder', 'decoded_test')
    assert_respond_to @p, :find_encoded_files
  end
  def test_decode_from_files_reads_encoded_files
    @p.decode_from_files(3, 'simple_test_encoder', 'decoded_test')
    assert_equal ['1','0','1','0','1','0','1','0','0','0','1','1','1','0','1','0','1','0','1'], @p.file_to_decode_contents('simple_test_encoder0.txt')
  end
  def test_encoded_files_are_saved_to_respecitve_decoders
    @p.decode_from_files(3, 'simple_test_encoder', 'decoded_test')
    assert_equal 3, @p.decoders.length
  end
end
