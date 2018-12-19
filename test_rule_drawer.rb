require 'minitest/autorun'
require 'chunky_png'
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
    @drawer = RuleDrawer.new(matrix, @colors, factor: 255)
  end

  def test_convert_to_pixel_with_factor_1
    cell = 0
    @drawer.factor = 1
    colorer = Minitest::Mock.new
    colorer.expect :rgb, true, [
      (@colors[0][:red]).round,
      (@colors[0][:green]).round,
      (@colors[0][:blue]).round
    ]
    assert @drawer.convert_to_pixel(cell, colorer)
    colorer.verify
  end

  def test_convert_to_pixel_with_factor_255
    cell = 0
    colorer = Minitest::Mock.new
    colorer.expect :rgb, true, [
      (@colors[0][:red]*255).round,
      (@colors[0][:green]*255).round,
      (@colors[0][:blue]*255).round
    ]
    assert @drawer.convert_to_pixel(cell, colorer)
    colorer.verify
  end

  # the overconcreteness of this test gestures towards
  # refactoring build_image
  def test_build_image
    image = Minitest::Mock.new
    image.expect :set_pixel, true, [0, 0, Integer]
    image.expect :set_pixel, true, [1, 0, Integer]
    image.expect :set_pixel, true, [2, 0, Integer]
    image.expect :set_pixel, true, [0, 1, Integer]
    image.expect :set_pixel, true, [1, 1, Integer]
    image.expect :set_pixel, true, [2, 1, Integer]
    assert @drawer.build_image(image)
    image.verify
  end
end
