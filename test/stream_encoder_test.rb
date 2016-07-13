require 'minitest/autorun'
require 'minitest/pride'
require './lib/stream_encoder'

class TestStreamEncoder < Minitest::Test
  def setup
    @s = ParaMorse::StreamEncoder.new
  end
  def test_it_exists
    assert_instance_of ParaMorse::StreamEncoder, @s
  end
  def test_stream_has_a_queue
    assert @s.current_queue
  end
  def test_stream_can_receive_letters
    assert_respond_to @s, :receive
  end
  def test_stream_puts_input_into_queue
    @s.receive('e')
    assert_equal 1, @s.current_queue.count
  end
  def test_stream_encoder_encodes_elements_in_queue
    @s.receive('e')
    assert_equal '1', @s.encode_one_letter
  end
  def test_stream_can_encode_one_word
    @s.receive('b')
    @s.receive('e')
    assert_equal '1110101010001', @s.encode_entire_stream
  end
  def test_stream_can_encode_statement
    @s.receive('h')
    @s.receive('e')
    @s.receive('l')
    @s.receive('l')
    @s.receive('o')
    @s.receive(' ')
    @s.receive('w')
    @s.receive('o')
    @s.receive('r')
    @s.receive('l')
    @s.receive('d')
    assert_equal '101010100010001011101010001011101010001110111011100000001011101110001110111011100010111010001011101010001110101', @s.encode_entire_stream
  end
end
