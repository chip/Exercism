class PerfectNumber
  def self.classify(num)
    raise ArgumentError.new('Classification is only possible for positive integers.') unless num.positive?

    factors = [1]
    current = 2
    limit = num / 2
    while current <= limit
      factors << current if (num % current).zero?
      current += 1
    end
    sum = factors.empty? ? 0 : factors.sum
    factors_other_than_itself = factors.size > 1
    if num == sum && factors_other_than_itself
      'perfect'
    elsif num < sum && factors_other_than_itself
      'abundant'
    else
      'deficient'
    end
  end
end
