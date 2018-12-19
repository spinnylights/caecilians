require 'minitest/autorun'
require_relative 'totalistic_ca'

class TestTotalisticCA < Minitest::Test
  def setup
    @columns = 10
    rows = 2
    @rule = [2, 0, 1, 2, 0, 1, 1] # a 3-color ca
    @ca = TotalisticCA.new(columns: @columns, rows: rows, rule: @rule)
  end

  def generate_rule(validity = :valid)
    max_value = rand(10) + 1 # ceiling could be any integer so the choice is arbitrary
    if validity == :invalid
      rule_length = rand((max_value*3) - 1) # neighborhood always has 3 cells
    else
      rule_length = max_value*3
    end
    rule = []
    rule_length.times do
      rule << rand(max_value + 1)
    end
    rule[rand(rule.length)] = max_value
    rule
  end

  def test_creating_ca_raises_argument_error_if_no_rule_is_supplied
    assert_raises(ArgumentError) do
      TotalisticCA.new(columns: 1, rows: 1, first_row: [1])
    end
  end

  def test_inexhaustive_rule_raises_argument_error
    assert_raises ArgumentError do
      TotalisticCA.new(rule: [5, 0, 1])
    end
  end

  def test_inexhaustive_rule_with_negative_numbers_raises_argument_error
    assert_raises ArgumentError do
      TotalisticCA.new(rule: [-3, 0, 1, 2, 0, 1, 1])
    end
  end

  def test_invalid_values_for_rule_in_first_row_raises_argument_error
    assert_raises ArgumentError do
      TotalisticCA.new(rule: @rule, first_row: [0, 1, -3])
    end
  end

  def test_not_supplying_first_row_creates_first_row
    refute_nil @ca.first_row
  end

  def test_default_length_is_10_if_no_first_row_supplied
    ca = TotalisticCA.new(rule: generate_rule)
    assert_equal 10, ca.columns
  end

  def test_columns_is_equal_to_first_row_columns_even_if_contradicting_columns_supplied
    first_row = [0]
    ca = TotalisticCA.new(rule: generate_rule, first_row: first_row, columns: 5)
    assert_equal first_row.length, ca.columns
  end

  def test_default_rows_is_10
    ca = TotalisticCA.new(rule: generate_rule)
    assert_equal 10, ca.rows
  end

  def test_random_first_row_columns
    assert_equal @columns, @ca.first_row.length
  end

  def test_random_first_row_made_from_rule
    # no first row supplied for @ca
    @ca.first_row.uniq.each do |val|
      assert_includes @rule, val
    end
  end

  def test_toroidal_borders_is_default
    ca = TotalisticCA.new(rule: @rule)
    assert_equal :toroidal, ca.borders
  end

  def test_unconnected_value_default_is_zero
    ca = TotalisticCA.new(rule: @rule)
    assert_equal 0, ca.unconnected_value
  end

  def test_random_tile
    assert_includes (0..2), @ca.random_tile # 3 colors
  end

  def test_next_row_toroidal
    @ca.borders = :toroidal
    row      = [2, 1, 0, 0, 1, 0, 2, 2, 0, 1]
    expected = [0, 2, 0, 0, 0, 2, 0, 0, 2, 2]
    assert_equal expected, @ca.next_row(row)
  end

  def test_next_row_unconnected_borders_zero
    @ca.borders = :unconnected
    @ca.unconnected_value = 0
    row      = [2, 1, 0, 0, 1, 0, 2, 2, 0, 1]
    expected = [2, 2, 0, 0, 0, 2, 0, 0, 2, 0]
    assert_equal expected, @ca.next_row(row)
  end

  def test_next_row_unconnected_borders_two
    @ca.borders = :unconnected
    @ca.unconnected_value = 2
    row      = [2, 1, 0, 0, 1, 0, 2, 2, 0, 1]
    expected = [1, 2, 0, 0, 0, 2, 0, 0, 2, 2]
    assert_equal expected, @ca.next_row(row)
  end

  def test_run
    rule = [1, 0, 0, 1] # 2-color rule
    first_row  = [0, 1, 1, 1]
    second_row = [0, 0, 1, 0]
    expected = [first_row, second_row]
    rows = 2
    ca = TotalisticCA.new(first_row: first_row, rows: rows, rule: rule)
    ca.borders = :unconnected
    ca.unconnected_value = 0
    assert_equal expected, ca.run
  end

  def test_scale
    row  = [0, 1, 1, 1]
    expected = [0, 0, 1, 1, 1, 1, 1, 1]
    assert_equal expected, @ca.scale(row, 2)
  end

  def test_run_scaled_up
    rule = [1, 0, 0, 1] # 2-color rule
    first_row  = [0, 1, 1, 1]
    second_row = [0, 0, 1, 0]
    expected = [
      [0, 0, 1, 1, 1, 1, 1, 1],
      [0, 0, 1, 1, 1, 1, 1, 1],
      [0, 0, 0, 0, 1, 1, 0, 0],
      [0, 0, 0, 0, 1, 1, 0, 0]
    ]
    rows = 2
    ca = TotalisticCA.new(first_row: first_row, rows: rows, rule: rule)
    ca.borders = :unconnected
    ca.unconnected_value = 0
    assert_equal expected, ca.run(scale: 2)
  end

  def test_check_valid_rule
    assert TotalisticCA.check_rule(generate_rule)
  end

  def test_check_invalid_rule
    refute TotalisticCA.check_rule(generate_rule(:invalid))
  end

  def test_check_valid_first_row
    first_row = [-2, 0, 1]
    assert TotalisticCA.check_first_row(first_row, @rule)
  end

  def test_check_invalid_first_row
    first_row = [-3, 0, 1]
    refute TotalisticCA.check_first_row(first_row, @rule)
  end
end
