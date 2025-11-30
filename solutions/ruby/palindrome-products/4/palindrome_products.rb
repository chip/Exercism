class Palindromes
  attr_reader :min_factor, :max_factor

  Palindrome = Struct.new(:factors, :value)

  def initialize(max_factor:, min_factor: 1)
    raise ArgumentError, 'min must be <= max' if min_factor > max_factor

    @min_factor = min_factor
    @max_factor = max_factor
    @smallest = nil
    @largest  = nil
  end

  def generate
    @results = Hash.new { |h, k| h[k] = [] }

    min_factor.upto(max_factor) do |i|
      i.upto(max_factor) do |j| # ensures i <= j like repeated_combination
        product = i * j
        next unless palindrome_fast?(product)

        @results[product] << [i, j]

        # track smallest
        if @smallest.nil? || product < @smallest.value
          @smallest = Palindrome.new([[i, j]], product)
        elsif product == @smallest.value
          @smallest.factors << [i, j]
        end

        # track largest
        if @largest.nil? || product > @largest.value
          @largest = Palindrome.new([[i, j]], product)
        elsif product == @largest.value
          @largest.factors << [i, j]
        end
      end
    end

    @results
  end

  def smallest
    @smallest || Palindrome.new([], nil)
  end

  def largest
    @largest || Palindrome.new([], nil)
  end

  private

  def palindrome_fast?(n)
    s = n.to_s
    s == s.reverse
  end
end
