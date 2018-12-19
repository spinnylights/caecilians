require 'minitest/autorun'
require_relative 'rule_drawer'

class RuleDrawerTest < Minitest::Test
  def setup
    matrix = [[0, 1, 2],[1, 2, 0]]
    @colors = [
      {
        red: 0.88,
        green: 0.26,
        blue: 0.71
      },
      {
        red: 1,
        green: 0.98,
        blue: 0.97
      },
      {
        red: 0.76,
        green: 0.92,
        blue: 0.99
      },
    ]
    @drawer = RuleDrawer.new(matrix, @colors)
  end

  def test_convert_to_pixel
    cell = 0
    colorer = Minitest::Mock.new
    colorer.expect :rgb, true, [
      (@colors[0][:red]).round,
      (@colors[0][:green]).round,
      (@colors[0][:blue]).round
    ]
    assert @drawer.convert_to_pixel(cell, colorer)
    colorer.verify
  end

  def test_convert_to_pixel_with_factor
    cell = 0
    @drawer.factor = 255
    colorer = Minitest::Mock.new
    colorer.expect :rgb, true, [
      (@colors[0][:red]*255).round,
      (@colors[0][:green]*255).round,
      (@colors[0][:blue]*255).round
    ]
    assert @drawer.convert_to_pixel(cell, colorer)
    colorer.verify
  end

  def test_build_image
    assert @drawer.build_image.display
  end
end
