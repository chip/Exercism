class SumOfMultiples
  def initialize(*args)
    @magical_items = [*args]
  end

  def to(level)
    return 0 if @magical_items.sum.zero?

    @magical_items.map do |item|
      (1..(level / item)).map { |i| i * item }
                         .select { |n| n < level }
    end.flatten.uniq.sum
  end
end
