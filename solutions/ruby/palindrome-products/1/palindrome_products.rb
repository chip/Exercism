class Palindromes
  attr_reader :max_factor, :min_factor, :palindromes

  Palindrome = Struct.new(:value, :factors)

  def initialize(max_factor:, min_factor: 1)
    raise ArgumentError.new('min must be <= max') if min_factor > max_factor

    @max_factor = max_factor
    @min_factor = min_factor
    @palindromes = []
  end

  def generate
    (min_factor..max_factor).each do |a|
      (a..max_factor).each do |b|
        value = a * b
        next unless palindrome?(value)

        if palindrome = @palindromes.find { |e| e.value == value }
          palindrome.factors.push([a, b])
        else
          @palindromes.push(Palindrome.new(value, [[a, b]]))
        end
      end
    end
  end

  def smallest
    return Palindrome.new(nil, []) if @palindromes.empty?

    @palindromes.sort_by(&:value).first
  end

  def largest
    return Palindrome.new(nil, []) if @palindromes.empty?

    @palindromes.sort_by(&:value).last
  end

  private

  def palindrome?(n)
    n.to_s == n.to_s.reverse
  end
end
