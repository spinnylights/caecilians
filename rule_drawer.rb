class RuleDrawer
  require 'chunky_png'

  attr_reader :matrix, :colors
  attr_accessor :factor
  def initialize(matrix, colors, options={})
    @matrix = matrix
    unless RuleDrawer.check_colors(colors, @matrix)
      raise ArgumentError, "too few colors specified"
    end
    @colors = colors
    @factor = options[:factor] || 1
  end

  def self.check_colors(colors, matrix)
    colors.length >= matrix.flatten.max + 1
  end

  def convert_to_pixel(cell, colorer = ChunkyPNG::Color)
    colorer.rgb(
      (colors[cell][:red]*factor).round,
      (colors[cell][:green]*factor).round,
      (colors[cell][:blue]*factor).round
    )
  end

  def build_image(image = nil)
    cols = matrix[0].length
    rows = matrix.length
    pixel_mat = matrix.map {|row| row.map {|cell| convert_to_pixel(cell)}}
    image ||= ChunkyPNG::Image.new(cols, rows)
    pixel_mat.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        image.set_pixel(x, y, cell)
      end
    end
    image
  end
end
