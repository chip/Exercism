class FlowerField
  attr_reader :input

  def self.annotate(input)
    return [''] if input == ['']

    new(input).annotate
  end

  def initialize(input)
    @input = input
  end

  def annotate
    grid.map do |(_, columns)|
      columns.map do |x, y|
        empty_cell?(x, y) ? adjacent(x, y) : cell_value(x, y)
      end.join
    end
  end

  private

  def adjacent(x, y)
    n = [
      cell_value(x - 1, y - 1), # "Up Left"
      cell_value(x - 1, y),     # "Up"
      cell_value(x - 1, y + 1), # "Up Right"
      cell_value(x, y + 1),     # "Right"
      cell_value(x + 1, y + 1), # "Down Right"
      cell_value(x + 1, y),     # "Down"
      cell_value(x + 1, y - 1), # "Down Left"
      cell_value(x, y - 1)      # "Left"
    ].join.scan('*').count

    n.zero? ? cell_value(x, y) : n
  end

  def cell_value(x, y)
    input[x][y] if valid_coords?(x, y)
  end

  def valid_coords?(x, y)
    row_range.cover?(x) && col_range.cover?(y) && value?(x, y)
  end

  def empty_cell?(x, y)
    value?(x, y) && input[x][y] == ' '
  end

  def value?(x, y)
    input && input[x] && input[x][y]
  end

  def grid
    if height == 1
      col_range.to_a.repeated_permutation(2).select { |x, _| x.zero? }.group_by(&:first)
    else
      row_range.to_a.repeated_permutation(2).group_by(&:first)
    end
  end

  def row_range
    (0...height)
  end

  def col_range
    (0...width)
  end

  def width
    input.first.size unless input.empty?
  end

  def height
    input.size
  end
end
