class Hamming
  def self.compute(strand1, strand2)
    raise ArgumentError if strand1.length != strand2.length

    (0..strand1.length).inject(0) do |count, n|
      count + (strand1[n] == strand2[n] ? 0 : 1)
    end
  end
end
