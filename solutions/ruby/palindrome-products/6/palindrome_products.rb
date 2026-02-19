class Palindromes
  Palindrome = Struct.new(:factors, :value)

  attr_reader :min_factor, :max_factor

  def initialize(max_factor:, min_factor: 1)
    raise ArgumentError, 'min must be <= max' if min_factor > max_factor

    @min_factor = min_factor
    @max_factor = max_factor
    @smallest = nil
    @largest  = nil
  end

  def generate
    # Find smallest
    min_factor.upto(max_factor) do |i|
      i.upto(max_factor) do |j|
        product = i * j
        next if product % 10 == 0 && product != 0
        next unless palindrome_int?(product)

        if @smallest.nil? || product < @smallest.value
          @smallest = Palindrome.new([[i, j]], product)
        elsif product == @smallest.value
          @smallest.factors << [i, j]
        end
      end
    end

    # Find largest (descending, with pruning)
    max_factor.downto(min_factor) do |i|
      i.downto(min_factor) do |j|
        product = i * j
        break if @largest && product < @largest.value
        next if product % 10 == 0 && product != 0
        next unless palindrome_int?(product)

        if @largest.nil? || product > @largest.value
          @largest = Palindrome.new([[j, i]], product)
        elsif product == @largest.value
          @largest.factors << [j, i]
        end
      end
    end

    nil
  end

  def smallest
    @smallest || Palindrome.new([], nil)
  end

  def largest
    @largest || Palindrome.new([], nil)
  end

  private

  # Fast integer palindrome check (no strings!)
  def palindrome_int?(n)
    original = n
    rev = 0
    while n > 0
      rev = (rev * 10) + (n % 10)
      n /= 10
    end
    rev == original
  end
end
