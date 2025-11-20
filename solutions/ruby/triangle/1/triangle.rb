class Triangle
  attr_reader :sides

  def initialize(sides)
    @sides = sides
  end

  def equilateral?
    valid? && (sides.all? { |s| s > 0 } && sides.all? { |s| s == sides.first })
  end

  def isosceles?
    valid? && (equilateral? || sides.tally.values.any? { |v| v == 2 })
  end

  def scalene?
    valid? && sides.tally.values.all? { |v| v == 1 }
  end

  private

  def valid?
    a, b, c = sides
    a + b >= c && b + c >= a && a + c >= b
  end
end
