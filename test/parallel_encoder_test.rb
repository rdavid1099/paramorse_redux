require 'minitest/autorun'
require 'minitest/pride'
require './lib/parallel_encoder'

class TestParallelEncoder < Minitest::Test
  def setup
    @p = ParaMorse::ParallelEncoder.new
  end
  def test_parallel_encoder_exists
    assert_instance_of ParaMorse::ParallelEncoder, @p
  end
  def test_parallel_encoder_has_encode_from_a_file_method
    assert_respond_to @p, :encode_from_file
  end
  def test_encode_from_file_receives_arguments
    @p.encode_from_file('test.txt', 1, 'test_encode.txt')
  end
  def test_encode_from_file_detects_files_without_txt
    @p.encode_from_file('test', 1, 'test_encode.txt')
    assert_equal 'test.txt', @p.filename_validator('test')
  end
  def test_encode_from_file_properly_reads_file_given
    @p.encode_from_file('test', 1, 'test_encode.txt')
    assert_equal 'hi b', @p.text_in_input_file
  end
  def test_encode_from_file_creates_stream_encoders
    @p.encode_from_file('test', 1, 'test_encode.txt')
    assert_equal 1, @p.encoders.count
  end
  def test_encode_from_file_makes_more_than_one_encoder
    @p.encode_from_file('test', 8, 'test_encoder.txt')
    assert_equal 8, @p.encoders.count
  end
  def test_encode_from_file_splits_text_from_file_into_array_of_characters
    @p.encode_from_file('test', 1, 'test_encoder.txt')
    assert_equal 4, @p.split_text_into_characters.count
  end
  def test_file_encoder_dumps_characters_into_encoders
    @p.encode_from_file('test', 1, 'test_encoder.txt')
    assert_equal 4, @p.encoders[0].current_queue.count
  end
end
