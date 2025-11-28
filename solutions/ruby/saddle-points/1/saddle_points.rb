require 'matrix'

class Grid
  def self.saddle_points(input)
    coordinates = []
    m = Matrix[*input]
    m.each_with_index do |e, x, y|
      max = m.row(x).max
      min = m.column(y).min
      coordinates.push({ 'row' => (x + 1), 'column' => (y + 1) }) if e == max && e == min
    end
    coordinates
  end
end
