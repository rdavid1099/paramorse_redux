require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/queue'

class QueueTest < MiniTest::Test

  def test_it_pushes_and_pops_a_character
    some_queue = ParaMorse::Queue.new

    some_queue.push('0')

    assert_equal '0', some_queue.pop
  end


  def test_it_pushes_and_pops_from_correct_ends
    some_queue = ParaMorse::Queue.new

    some_queue.push('0')
    some_queue.push('1')
    some_queue.push('1')

    assert_equal '0', some_queue.pop
    assert_equal '1', some_queue.pop
    assert_equal '1', some_queue.pop
  end

  def test_it_pops_multiple_characters
    some_queue = ParaMorse::Queue.new

    some_queue.push('0')
    some_queue.push('1')
    some_queue.push('1')

    assert_equal '10', some_queue.pop_multiple(2)
  end

  def test_it_accepts_integers_as_input
    some_queue = ParaMorse::Queue.new

    some_queue.push(0)

    assert_equal 0, some_queue.pop
  end

  def test_it_counts_its_elements
    some_queue = ParaMorse::Queue.new

    some_queue.push('0')
    some_queue.push('1')
    some_queue.push('0')

    assert_equal 3, some_queue.count
  end

  def test_it_sees_the_newest_element
    some_queue = ParaMorse::Queue.new

    some_queue.push('0')
    some_queue.push('1')

    assert_equal ['1'], some_queue.tail
  end

  def test_it_sees_the_newest_n_elements
    some_queue = ParaMorse::Queue.new

    some_queue.push('0')
    some_queue.push('1')
    some_queue.push('1')
    some_queue.push('0')
    some_queue.push('0')

    assert_equal ['0', '0', '1'], some_queue.tail(3)
  end

  def test_it_sees_the_oldest_element
    some_queue = ParaMorse::Queue.new

    some_queue.push('0')
    some_queue.push('1')

    assert_equal ['0'], some_queue.peek
  end

  def test_it_sees_the_oldest_n_elements
    some_queue = ParaMorse::Queue.new

    some_queue.push('0')
    some_queue.push('1')
    some_queue.push('1')
    some_queue.push('0')
    some_queue.push('0')

    assert_equal ['0', '1', '1'], some_queue.peek(3)
  end

  def test_it_can_clear_all_its_elements
    some_queue = ParaMorse::Queue.new

    some_queue.push('0')
    some_queue.push('1')
    some_queue.push('1')
    some_queue.push('0')
    some_queue.push('0')
    some_queue.clear

    assert_equal 0, some_queue.count
  end

end
