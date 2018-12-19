class RuleDrawer
  require 'chunky_png'

  attr_reader :matrix
  attr_accessor :colors, :factor
  def initialize(matrix, colors, factor = 1)
    @matrix = matrix
    @colors = colors
    @factor = factor
  end

  def convert_to_pixel(cell, colorer = ChunkyPNG::Color)
    colorer.rgb(
      (colors[cell][:red]*factor).round,
      (colors[cell][:green]*factor).round,
      (colors[cell][:blue]*factor).round
    )
  end

  def build_image
    cols = matrix[0].length
    rows = matrix.length
    pixel_mat = matrix.map {|row| row.map {|cell| convert_to_pixel(cell)}}
#    flat_mat = matrix.flatten
#    flat_mat.map! do |cell|
#      convert_to_pixel(cell)
#    end
    image = ChunkyPNG::Image.new(cols, rows)
    pixel_mat.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        image.set_pixel(x, y, cell)
      end
    end
    image
  end
end
