require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/paramorse'

class TestFileEncoder < MiniTest::Test
  def setup
    @f = ParaMorse::FileEncoder.new
  end
  def test_file_encoder_exists
    assert @f
  end
  def test_file_encoder_can_receive_a_filename
    assert @f.encode('filename', 'dummy')
  end
  def test_file_encoder_searches_for_filename
    assert_equal 'File does not exist', @f.encode('not_filename.txt', 'dummy')
  end
  def test_file_encoder_finds_existing_files
    @f.encode('test.txt', 'dummy')
    assert_equal true, @f.file_validated
  end
  def test_file_encoder_adds_txt_to_filenames_without_it
    @f.encode('another_test', 'dummy')
    assert_equal true, @f.file_validated
  end
  def test_file_encoder_reads_text_file
    @f.encode('another_test', 'dummy')
    assert_equal 'hi b', @f.file_to_encode_contents
  end
  def test_file_encodes_english_in_text_file
    @f.encode('another_test', 'dummy')
    assert_equal '10101010001010000000111010101', @f.encoded_text
  end
  def test_filename_of_file_to_be_saved_checks_for_txt
    @f.encode('another_test', 'test_encode')
    assert_equal "another_test.txt", @f.plain_filename
    assert_equal "test_encode.txt", @f.encode_filename
  end
  def test_file_saves_encoded_text_to_filename
    @f.encode('another_test', 'test_encode')
    assert_equal true, File.exists?('test_encode.txt')
  end
  def test_file_encodes_large_text_file
    @f.encode('large_test_file', 'large_test_encoded')
    assert File.read('large_test_encoded.txt').length > 100
  end
  def test_file_encoder_handles_special_characters
    @f.encode('spec_chars_test', 'spec_chars_encoded')
  end
  def test_file_encoder_on_a_complete_news_story
    @f.encode('real_world_news_test', 'real_world_news_encode')
  end
end
