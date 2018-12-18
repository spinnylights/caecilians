require 'minitest/autorun'
require_relative 'rule_drawer'

class RuleDrawerTest < Minitest::Test
  def setup
    matrix = [["A", "B", "0"],["C", "D", "0"]]
    @drawer = RuleDrawer.new(matrix)
  end

  def test_convert_to_pixel
    cell = "0"
    assert @drawer.convert_to_pixel(cell)
  end

  def test_build_image
    assert @drawer.build_image.display
  end
end
