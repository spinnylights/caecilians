require 'minitest/autorun'
require_relative 'totalistic_ca'

class TestTotalisticCA < Minitest::Test
  def setup
    @length = 10
    rows = 2
    @rule = TotalisticCA.new(length: @length, rows: rows)
  end

  def test_make_binary
    arr = ["A", "B", "C", "D", "0"]
    assert_equal [1, 1, 1, 1, 0], @rule.make_binary(arr)
  end

  def test_first_row_length
    assert_equal @length, @rule.first_row.length
  end

  def test_random_tile
    assert @rule.random_tile
  end

  def test_determine_child
    assert_instance_of String, @rule.determine_child([1, 1, 0])
  end

  def test_next_row
    row      = ["A", "B", "0", "0", "D", "0", "A", "C"]
    expected = ["0", "0", "B", "D", "C", "0", "0", "0"]
    assert_equal expected, @rule.next_row(row)
  end

  def test_make_matrix
    first_row  = ["A", "C", "0", "0"]
    second_row = ["0", "0", "B", "0"]
    expected = [first_row, second_row]
    rows = 2
    rule = TotalisticCA.new(first_row: first_row, rows: rows)
    assert_equal expected, rule.make_matrix
  end
end
