class TotalisticCA
  attr_reader :columns, :rows, :first_row, :rule
  attr_accessor :borders, :unconnected_value
  def initialize(args)
    unless args[:rule]
      raise ArgumentError, "rule must be supplied at initialization"
    end

    if TotalisticCA.check_rule(args[:rule])
      @rule = args[:rule]
    else
      raise ArgumentError, "supplied rule does not cover all cases"
    end

    if args[:columns] && args[:first_row]
      warn "ignoring columns since first_row was supplied"
    end

    if args[:first_row]
      @first_row = args[:first_row]
      @columns    = first_row.length
    else
      @columns    = args[:columns] || 10
      @first_row = random_first_row
    end
    @rows = args[:rows] || 10
    @borders = args[:borders] || :toroidal
    @unconnected_value = args[:unconnected_value] || 0
  end

  def self.check_rule(rule)
    rule.length >= rule.map {|n| n.abs}.max*3 # neighborhood always has 3 cells
  end

  def random_tile
    rule.uniq.sample
  end

  def random_first_row
    Array.new(columns).map {random_tile}
  end

  def next_row(previous_row)
    next_row = Array.new(previous_row.length)
    n = 0
    next_row.map do |cell|
      total = nil

      if n == 0
        if borders == :toroidal
          total = previous_row.last + previous_row[n] + previous_row[n+1]
        else
          total = unconnected_value + previous_row[n] + previous_row[n+1]
        end
      elsif n == previous_row.length - 1
        if borders == :toroidal
          total = previous_row[n-1] + previous_row[n] + previous_row.first
        else
          total = previous_row[n-1] + previous_row[n] + unconnected_value
        end
      else
        total = previous_row[n-1] + previous_row[n] + previous_row[n+1]
      end

      unless total
        raise TypeError, "total remained nil through a next_row map cycle"
      end

      n+=1
      rule[total]
    end
  end

  def scale(row, scale)
    scaled_row = []
    row.each do |c|
      scale.times do
        scaled_row << c
      end
    end
    scaled_row
  end

  def run(options = {})
    matrix = [first_row]
    (0...rows - 1).each do |row|
      new_row = next_row(matrix[row])
      matrix << new_row
    end
    if options[:scale]
      scaled_matrix = []
      matrix.each do |row|
        options[:scale].times do
          scaled_row = scale(row, options[:scale])
          scaled_matrix << scaled_row
        end
      end
      return scaled_matrix
    else
      return matrix
    end
  end
end
