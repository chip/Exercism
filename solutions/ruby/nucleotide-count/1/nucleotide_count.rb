class Nucleotide
  def self.from_dna(input)
    raise ArgumentError unless input.match(/^[ACGT]*$/)

    new(input)
  end

  def initialize(input)
    @input = input
  end

  def histogram
    nucleotides = { 'A' => 0, 'C' => 0, 'G' => 0, 'T' => 0 }
    @input.chars.tally.each_with_object(nucleotides) do |(k, v), hsh|
      hsh[k] = v + nucleotides[k]
    end
  end
end
