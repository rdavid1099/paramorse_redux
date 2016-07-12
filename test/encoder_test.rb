require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/paramorse'

class EncoderTest < MiniTest::Test

  def test_it_takes_and_returns_strings
    encoder = ParaMorse::Encoder.new

    assert encoder.encode("hello").is_a?(String)
  end

  def test_it_encodes_a_word_in_morse
    encoder = ParaMorse::Encoder.new
    expected = "1010101000100010111010100010111010100011101110111"

    assert_equal expected, encoder.encode("hello")
  end

  def test_it_encodes_multiple_words_in_morse
    encoder = ParaMorse::Encoder.new
    expected = "101010100010000000111010101"
    assert_equal expected, encoder.encode('he b')
  end

  def test_it_encodes_multiple_words_in_morse
    encoder = ParaMorse::Encoder.new
    expected = "101010100010001011101010001011101010001110111011100000001011101110001110111011100010111010001011101010001110101"
    assert_equal expected, encoder.encode("hello world")
  end

  def test_it_encodes_more_words
    encoder = ParaMorse::Encoder.new
    expected = "101010100010001011101010001011101010001110111011100000001011101110001110111011100010111010001011101010001110101"
    assert_equal expected, encoder.encode("hello world")
  end

  def test_it_encodes_other_words_in_morse
    encoder = ParaMorse::Encoder.new
    expected = "101010100010001011101010001011101010001110111011100000001011101110001110111011100010111010001011101010001110101"
    assert_equal expected, encoder.encode("hello world")
  end
  def test_it_handles_special_characters
    encoder = ParaMorse::Encoder.new
    expected = "1010101000100010111010100010111010100011101110111,00000001011101110001110111011100010111010001011101010001110101"
    assert_equal expected, encoder.encode("hello, world")
  end
end
