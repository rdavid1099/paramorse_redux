require_relative 'test_handler'

class LetterDecoderTest < MiniTest::Test

  def test_it_takes_and_returns_strings
    letter_decoder = ParaMorse::LetterDecoder.new

    assert letter_decoder.decode("10111").is_a?(String)
  end

  def test_it_decodes_morse_sequences
    letter_decoder = ParaMorse::LetterDecoder.new

    assert_equal "a", letter_decoder.decode("10111")
  end

end
