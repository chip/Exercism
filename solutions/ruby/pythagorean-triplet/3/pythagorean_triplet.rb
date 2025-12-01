class PythagoreanTriplet
  def self.triplets_with_sum(sum)
    results = []

    # Using Euclid's formula:
    # sum = a + b + c = 2 * k * m * (m + n)
    max_m = Math.sqrt(sum / 2).to_i

    (2..max_m).each do |m|
      (1...m).each do |n|
        # must be opposite parity and coprime
        next if (m - n).even?
        next unless m.gcd(n) == 1

        base_sum = 2 * m * (m + n)
        next unless sum % base_sum == 0

        k = sum / base_sum

        a = k * ((m * m) - (n * n))
        b = k * (2 * m * n)
        c = k * ((m * m) + (n * n))

        results << [a, b, c].sort
      end
    end

    results.sort
  end
end
