class SpiralMatrix
  attr_reader :size, :numbers, :directions, :index, :spiral

  def initialize(size)
    @numbers = (1..(size**2)).to_a
    @spiral = Array.new(size) { Array.new(size, 'x') }
    @row = 0
    @col = 0
    @directions = %i[right down left up]
    @index = 0
    @current_direction = directions[index]
  end

  def matrix
    numbers.each do |n|
      backtrack unless cell_available?
      spiral[@row][@col] = n
      move
    end
    spiral
  end

  def cell_available?
    spiral[@row] && spiral[@row][@col] == 'x'
  end

  def backtrack
    case @current_direction
    when :right then @col -= 1
    when :down then @row -= 1
    when :left then @col += 1
    when :up then @row += 1
    end
    @index = (index + 1) % directions.size
    @current_direction = directions[index]
    move
  end

  def move
    case @current_direction
    when :right then @col += 1
    when :down then @row += 1
    when :left then @col -= 1
    when :up then @row -= 1
    end
  end
end
