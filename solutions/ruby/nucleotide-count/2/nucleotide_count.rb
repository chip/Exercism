class Nucleotide
  def self.from_dna(strand)
    raise ArgumentError unless strand.match(/^[ACGT]*$/)

    new(strand)
  end

  def initialize(strand)
    @strand = strand
  end

  def histogram
    default_histogram = { 'A' => 0, 'C' => 0, 'G' => 0, 'T' => 0 }
    @strand.chars.each_with_object(default_histogram) { |c, hsh| hsh[c] += 1 }
  end
end
