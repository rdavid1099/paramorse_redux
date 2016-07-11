require_relative 'test_handler'

class LetterEncoderTest < MiniTest::Test

  def test_it_takes_and_returns_strings
    letter_encoder = ParaMorse::LetterEncoder.new

    assert letter_encoder.encode("a").is_a?(String)
  end

  def test_it_encodes_letters_in_morse
    letter_encoder = ParaMorse::LetterEncoder.new

    assert_equal "10111", letter_encoder.encode("a")
  end

end
