class Triangle
  attr_reader :sides, :triangle

  def initialize(sides)
    @sides = sides
    a, b, c = sides
    valid_sizes = a + b >= c && b + c >= a && a + c >= b
    @triangle = valid_sizes && sides.all?(&:positive?)
  end

  def equilateral?
    triangle && sides.all? { |s| s == sides.first }
  end

  def isosceles?
    triangle && (equilateral? || sides.tally.values.any? { |v| v == 2 })
  end

  def scalene?
    triangle && sides.tally.values.all? { |v| v == 1 }
  end
end
