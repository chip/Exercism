class Prime
  def self.nth(n)
    raise ArgumentError if n < 1
    return cache[n - 1] if cache.size >= n

    last = cache.last

    loop do
      last += 2
      cache << last if is_prime?(last, cache)
      break if cache.size >= n
    end
    cache.last
  end

  def self.is_prime?(number, factors)
    root = Math.sqrt(number).floor
    factors.each do |f|
      break if f > root
      return false if number % f == 0
    end
    true
  end

  private

  def self.cache
    @cache ||= [2, 3]
  end
end
