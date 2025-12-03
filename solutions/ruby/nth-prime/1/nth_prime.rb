class Prime
  def self.nth(stop)
    raise ArgumentError if stop.zero?

    primes = []
    generate.each_with_index do |n, i|
      break if i + 1 > stop

      primes << n
      next
    end
    primes.last
  end

  def self.generate
    Enumerator.new do |y|
      n = 2
      loop do
        y << n if prime?(n)
        n += 1
      end
    end.lazy
  end

  def self.prime?(n)
    return false if n < 2

    (2..n / 2).none? { |i| n % i == 0 }
  end
end
