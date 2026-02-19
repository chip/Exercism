class PerfectNumber
  def self.classify(number)
    raise ArgumentError.new('Classification is only possible for positive integers.') unless number.positive?

    sum = (1..number / 2).sum { |n| (number % n).zero? ? n : 0 }
    if number == sum
      'perfect'
    elsif number < sum
      'abundant'
    else
      'deficient'
    end
  end
end
