require_relative 'test_handler'

class DecoderTest < MiniTest::Test

  def test_it_takes_and_returns_strings
    decoder = ParaMorse::Decoder.new
    sequence_to_decode = "1010101000100010111010100010111010100011101110111"

    assert decoder.decode(sequence_to_decode).is_a?(String)
  end

  def test_it_divides_into_letters
    decoder = ParaMorse::Decoder.new
    sequence_to_decode = "1010101000100010111010100010111010100011101110111"

    num_of_letters = decoder.split(sequence_to_decode).count

    assert_equal 5, num_of_letters
  end

  def test_it_decodes_all_letters
    decoder = ParaMorse::Decoder.new
    sequence_to_decode = "1010101000100010111010100010111010100011101110111"

    decoder.decode(sequence_to_decode)
    decoded = decoder.decode_letters

    assert_equal ['h', 'e', 'l', 'l', 'o'], decoded
  end

  def test_it_decodes_a_word
    decoder = ParaMorse::Decoder.new
    sequence_to_decode = "1010101000100010111010100010111010100011101110111"

    word = decoder.decode(sequence_to_decode)

    assert_equal 'hello', word
  end

  def test_it_decodes_multiple_words
    decoder = ParaMorse::Decoder.new
    sequence_to_decode = "1010101000100010111010100010111010100011101110111000001011101110001110111011100010111010001011101010001110101"

    phrase = decoder_decode(sequence_to_decode)

    assert_equal "hello world", phrase
  end

end
