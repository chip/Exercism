class PythagoreanTriplet
  def self.triplets_with_sum(sum)
    # a < b < c, and a + b + c = sum
    # so: a < sum/3, b < sum/2
    (1..sum / 3).each_with_object([]) do |a, results|
      (a + 1..sum / 2).each do |b|
        c = sum - a - b
        break if c <= b # maintain ordering

        # Pythagorean check
        results << [a, b, c] if (a * a) + (b * b) == c * c
      end
    end
  end
end
