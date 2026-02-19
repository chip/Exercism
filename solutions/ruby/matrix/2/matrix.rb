class Matrix
  def initialize(text)
    @matrix = text.lines.map { |line| line.split.map(&:to_i) }
  end

  def row(ndx)
    @matrix[ndx - 1]
  end

  def column(col)
    @matrix.map { |row| row[col - 1] }
  end
end
