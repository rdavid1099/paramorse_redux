require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/stream_decoder'

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
  def test_stream_knows_if_its_empty
    assert_equal true, @s.empty?
  end
  def test_stream_handles_special_characters
    @s.receive("11101,")
    assert_equal "n,", @s.decode_letter
  end

end
