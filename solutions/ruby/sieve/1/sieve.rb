class Sieve
  attr_reader :ceiling

  def initialize(ceiling)
    @ceiling = ceiling
  end

  def primes
    return [] if ceiling < 2

    generate.to_a
  end

  private

  def generate
    Enumerator.new do |y|
      known = []
      n = 2
      while (known.last || 1) < ceiling
        y << n if known.none? { |p| p * p <= n && n % p == 0 }
        known << n
        n += 1
      end
    end.lazy
  end
end
