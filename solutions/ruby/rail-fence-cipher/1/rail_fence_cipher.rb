class RailFenceCipher
  def self.encode(text, rows)
    grid = Array.new(rows) { Array.new(text.size) }
    cartesian_for(text, rows).each_with_index do |(row, col), i|
      grid[row][col] = text[i]
    end
    grid.map(&:join).join
  end

  def self.decode(text, rows)
    chars = text.dup
    grid = Array.new(rows) { Array.new(text.size) }
    result = cartesian_for(text, rows)
    (0...rows).to_a.map do |i|
      result.select { |x, _| x == i }
    end.each_with_index do |row, i|
      chunk = chars.slice!(0, row.size)
      row.each_with_index do |(x, y), j|
        grid[x][y] = chunk[j]
      end
    end
    result.map { |(x, y)| grid[x][y] }.join
  end

  def self.cartesian_for(text, rows)
    size = text.size
    a = (0...rows).to_a
    alternating = []
    size.times { |i| alternating.push(i.even? ? a : a.reverse) }
    column_indexes = alternating
                     .flatten
                     .map(&:to_s)
                     .join
                     .squeeze("0|#{rows - 1}")
                     .slice(0, size)
                     .chars
                     .map(&:to_i)
                     .zip((0...size).to_a)
  end
end
