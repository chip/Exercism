class RailFenceCipher
  attr_reader :text, :rows

  def initialize(text, rows)
    @text = text
    @rows = rows
  end

  def self.encode(text, rows)
    new(text, rows).encode
  end

  def self.decode(text, rows)
    new(text, rows).decode
  end

  def encode
    filled_grid.map(&:join).join
  end

  def decode
    remaining = text.dup

    # Group coordinates by rail number
    rows = cartesian_for.group_by(&:first).values

    rows.each do |row_coords|
      # Pull exactly enough characters for this rail
      segment = remaining.slice!(0, row_coords.size)

      # Lay characters back into their positions
      row_coords.each_with_index do |(_row, col), idx|
        grid[_row][col] = segment[idx]
      end
    end

    # Read off the plaintext
    grid.transpose.flatten.compact.join
  end

  private

  def grid
    @grid ||= Array.new(rows) { Array.new(size) }
  end

  def filled_grid
    cartesian_for.each_with_index do |(row, col), idx|
      grid[row][col] = text[idx]
    end
    grid
  end

  def cartesian_for
    @cartesian_for ||= row_indices.zip(column_indices)
  end

  def row_indices
    @row_indices ||= zigzag_cycle.first(size)
  end

  def column_indices
    0...size
  end

  def zigzag_cycle
    down = (0...rows).to_a
    up   = (1..rows - 2).to_a.reverse
    (down + up).cycle
  end

  def size
    text.size
  end
end
