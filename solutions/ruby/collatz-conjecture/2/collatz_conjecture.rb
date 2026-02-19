class CollatzConjecture
  def self.steps(num, count = 0)
    raise ArgumentError unless num.positive?
    return count if num == 1

    next_num = num.even? ? num / 2 : (num * 3) + 1
    steps(next_num, count + 1)
  end
end
