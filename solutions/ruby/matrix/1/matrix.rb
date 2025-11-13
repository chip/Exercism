class Matrix
  def initialize(str)
    @matrix = str.split("\n").inject([]) do |rows, line|
      rows << line.split.inject([]) do |columns, n|
        columns << Integer(n)
      end
    end
  end

  def row(ndx)
    @matrix[ndx - 1]
  end

  def column(col)
    @matrix.map { |row| row[col - 1] }
  end
end
