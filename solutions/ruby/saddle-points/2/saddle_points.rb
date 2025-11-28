require 'matrix'

class Grid
  def self.saddle_points(input)
    m = Matrix[*input]
    m.each_with_index.each_with_object([]) do |(e, x, y), coordinates|
      max = m.row(x).max
      min = m.column(y).min
      if e == max && e == min
        coordinates.push({ 'row' => (x + 1), 'column' => (y + 1) })
      else
        coordinates
      end
    end
  end
end
