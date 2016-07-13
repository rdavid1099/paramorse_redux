module ParaMorse

  LETTERS_TO_MORSE = {
    "a" => "10111",
    "b" => "111010101",
    "c" => "11101011101",
    "d" => "1110101",
    "e" => "1",
    "f" => "101011101",
    "g" => "111011101",
    "h" => "1010101",
    "i" => "101",
    "j" => "1011101110111",
    "k" => "111010111",
    "l" => "101110101",
    "m" => "1110111",
    "n" => "11101",
    "o" => "11101110111",
    "p" => "10111011101",
    "q" => "1110111010111",
    "r" => "1011101",
    "s" => "10101",
    "t" => "111",
    "u" => "1010111",
    "v" => "101010111",
    "w" => "101110111",
    "x" => "11101010111",
    "y" => "1110101110111",
    "z" => "11101110101",
    " " => "0000000",
    "1" => "10111011101110111",
    "2" => "101011101110111",
    "3" => "1010101110111",
    "4" => "10101010111",
    "5" => "101010101",
    "6" => "11101010101",
    "7" => "1110111010101",
    "8" => "111011101110101",
    "9" => "11101110111011101",
    "0" => "1110111011101110111"
  }

  class Decoder
    def decode(input)
      @input = input
      return decode_words(@input.split(/0000000*/)) if @input =~ /0000000*/
      return LETTERS_TO_MORSE.key(@input) unless @input =~ /000/
      return decode_letters(@input.split('000'))
    end

    def decode_words(words_split)
      decoded_words = words_split.map {|word| "#{decode(word)} "}
      return decoded_words.join.chop
    end

    def decode_letters(letters_split)
      decoded_letters = letters_split.map do |letter|
        if special_characters_found(letter.chars)
          decode_special_characters(letter.chars)
        elsif LETTERS_TO_MORSE.key(letter) == nil
          letter
        else
          decode(letter)
        end
      end
      decoded_letters.join
    end

    def special_characters_found(letter)
      !letter.all? { |digit| digit =~ /\w/ }
    end

    def decode_special_characters(letter)
      letter_without_spec_char = Array.new
      spec_char = Array.new
      letter.each do |digit|
        if digit =~ /\w/
          letter_without_spec_char << digit
        else
          spec_char << digit
        end
      end
      "#{decode(letter_without_spec_char.join)}#{spec_char.join}"
    end
  end
end
