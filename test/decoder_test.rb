require 'minitest/autorun'
require 'minitest/pride'
require '../lib/paramorse'

class DecoderTest < MiniTest::Test
  def setup
    @d = ParaMorse::Decoder.new
  end

  def test_it_takes_and_returns_strings
    sequence_to_decode = "1010101000100010111010100010111010100011101110111"

    assert @d.decode(sequence_to_decode).is_a?(String)
  end

  def test_decoder_decodes_one_letter
    assert_equal 'e', @d.decode('1')
  end

  def test_decoder_decodes_two_letters
    assert_equal 'be', @d.decode('1110101010001')
  end

  def test_it_decodes_all_letters
    sequence_to_decode = "1010101000100010111010100010111010100011101110111"
    assert_equal 'hello', @d.decode(sequence_to_decode)
  end

  def test_it_decodes_multiple_words
    sequence_to_decode = "101010100010001011101010001011101010001110111011100000001011101110001110111011100010111010001011101010001110101"
    assert_equal "hello world", @d.decode(sequence_to_decode)
  end

end
