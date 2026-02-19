class Squares
  attr_reader :limit

  def initialize(limit)
    @limit = limit
  end

  def square_of_sum
    (1..limit).sum**2
  end

  def sum_of_squares
    (1..limit).map { |n| n**2 }.sum
  end

  def difference
    square_of_sum - sum_of_squares
  end
end
