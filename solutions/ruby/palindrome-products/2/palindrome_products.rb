class Palindromes
  attr_reader :min_factor, :max_factor, :palindromes

  Palindrome = Struct.new(:factors, :value)

  def initialize(min_factor: 1, max_factor: nil)
    raise ArgumentError.new('min must be <= max') if min_factor > max_factor

    @min_factor = min_factor
    @max_factor = max_factor
  end

  def generate
    @palindromes = (min_factor..max_factor)
                   .to_a
                   .repeated_combination(2)
                   .each_with_object({}) do |(num1, num2), result|
      if palindrome? num1 * num2
        result[num1 * num2] ||= []
        result[num1 * num2] << [num1, num2]
      end
    end.sort
  end

  def largest
    find_palindrome(:last)
  end

  def smallest
    find_palindrome(:first)
  end

  private

  def find_palindrome(method)
    if palindrome = palindromes.public_send(method)
      Palindrome.new(palindrome[1], palindrome[0])
    else
      Palindrome.new([], nil)
    end
  end

  def palindrome?(number)
    number.to_s == number.to_s.reverse
  end
end
