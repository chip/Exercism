class RailFenceCipher
  attr_reader :text, :rows

  def initialize(text, rows)
    @text = text
    @rows = rows
  end

  def encode
    cartesian_for.each_with_index do |(row, col), i|
      grid[row][col] = text[i]
    end
    grid.map(&:join).join
  end

  def decode
    chars = text.dup
    cartesian_for.group_by(&:first)
                 .values
                 .each_with_index do |row, i|
      chunk = chars.slice!(0, row.size)
      row.each_with_index { |(x, y), j| grid[x][y] = chunk[j] }
    end
    cartesian_for.map { |(x, y)| grid[x][y] }.join
  end

  def grid
    @grid ||= Array.new(rows) { Array.new(text.size) }
  end

  def cartesian_for
    @cartesian_for ||= zigzag
                       .flatten
                       .map(&:to_s)
                       .join
                       .squeeze("0|#{rows - 1}")
                       .slice(0, size)
                       .chars
                       .map(&:to_i)
                       .zip((0...size).to_a)
  end

  def zigzag
    @zigzag ||= Array.new(rows) { [] }.tap do |fence|
      size.times { |i| fence.push(i.even? ? row_range : row_range.reverse) }
    end
  end

  def row_range
    @row_range ||= (0...rows).to_a
  end

  def size
    text.size
  end

  def self.encode(text, rows)
    new(text, rows).encode
  end

  def self.decode(text, rows)
    new(text, rows).decode
  end
end
