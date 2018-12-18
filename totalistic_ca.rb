class TotalisticCA
  attr_reader :length, :rows, :first_row
  def initialize(args)
    if args[:length] && args[:first_row]
      warn "ignoring length since first_row was supplied"
    end
    if args[:first_row]
      @first_row = args[:first_row]
      @length    = first_row.length
    else
      @length    = args[:length] || 10
      @first_row = random_first_row
    end
    @rows = args[:rows] || 10
  end

  EMPTY = "0"
  A     = "A"
  B     = "B"
  C     = "C"
  D     = "D"

  def random_tile
    if rand(2) == 1
      [A, B, C, D].sample
    else
      EMPTY
    end
  end

  def random_first_row
    Array.new(length).map {random_tile}
  end

  def make_binary(arr)
    arr.map do |n|
      if n == EMPTY
        0
      else
        1
      end
    end
  end

  def determine_child(set)
    case set
    when [1, 1, 1]
      EMPTY
    when [1, 1, 0]
      A
    when [1, 0, 1]
      B
    when [1, 0, 0]
      EMPTY
    when [0, 1, 1]
      C
    when [0, 1, 0]
      D
    when [0, 0, 1]
      A
    when [0, 0, 0]
      EMPTY
    end
  end

  def next_row(unprepared_row)
    next_row = []
    string_row = unprepared_row.unshift(EMPTY) << (EMPTY)
    row = make_binary(string_row)
    (0..(row.length - 3)).each do |index|
      set = row[index..(index + 2)]
      next_row << determine_child(set)
    end
    unprepared_row.shift
    unprepared_row.pop
    next_row
  end

  def make_matrix
    matrix = [first_row]
    (0...rows - 1).each do |row|
      new_row = next_row(matrix[row])
      matrix << new_row
    end
    matrix
  end
end
