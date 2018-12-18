class RuleDrawer
  require 'chunky_png'

  attr_reader :matrix
  def initialize(matrix)
    @matrix = matrix
  end

  def convert_to_pixel(cell)
    red, blue, green = 0, 0, 0
    case cell
    when "0"
      red = 255
      green = 255
      blue = 255
    when "A"
      red = 242
      green = rand(64..126)
      blue = 29
    when "B"
      red = 21
      green = 191
      blue = rand(23..104)
    when "C"
      red = rand(80..183)
      green = 21
      blue = 191
    when "D"
      red = 252
      green = rand(168..192)
      blue = rand(219..241)
    end
    ChunkyPNG::Color.rgb(red, green, blue)
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
