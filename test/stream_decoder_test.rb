require 'Minitest/autorun'
require 'Minitest/pride'
require '../lib/paramorse'

class TestStreamDecoder < MiniTest::Test
  def setup
    @s = ParaMorse::StreamDecoder.new
  end
  def test_stream_exists
    assert @s
  end
  def test_stream_can_take_in_values
    assert @s.receive('1')
  end
  def test_stream_can_take_in_two_values
    @s.receive('1')
    @s.receive('0')
    assert_equal 2, @s.current_queue.count
  end
  def test_stream_can_decode_a_letter
    @s.receive('1')
    assert_equal 'e', @s.decode
  end
  def test_stream_can_decode_longer_morse_letter
    @s.receive("1")
    @s.receive("0")
    @s.receive("1")
    @s.receive("0")
    @s.receive("1")
    @s.receive("0")
    @s.receive("1")
    assert_equal 'h', @s.decode
  end
  def test_stream_can_decode_two_letters
    @s.receive("1")
    @s.receive("0")
    @s.receive("1")
    @s.receive("0")
    @s.receive("1")
    @s.receive("0")
    @s.receive("1")
    @s.receive("0")
    @s.receive("0")
    @s.receive("0")
    @s.receive("1")
    assert_equal 'he', @s.decode
  end
  def test_stream_can_decode_two_words
    @s.receive("1")
    @s.receive("0")
    @s.receive("1")
    @s.receive("0")
    @s.receive("1")
    @s.receive("0")
    @s.receive("1")
    @s.receive("0")
    @s.receive("0")
    @s.receive("0")
    @s.receive("1")
    @s.receive("0")
    @s.receive("0")
    @s.receive("0")
    @s.receive("0")
    @s.receive("0")
    @s.receive("0")
    @s.receive("0")
    @s.receive("1")
    @s.receive("1")
    @s.receive("1")
    @s.receive("0")
    @s.receive("1")
    @s.receive("0")
    @s.receive("1")
    @s.receive("0")
    @s.receive("1")
    assert_equal 'he b', @s.decode
  end
end
