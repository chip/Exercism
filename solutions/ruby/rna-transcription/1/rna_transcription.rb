class Complement
  NUCLEOTIDES = { 'G' => 'C', 'C' => 'G', 'T' => 'A', 'A' => 'U' }.freeze

  def self.of_dna(strand)
    return '' if strand.empty?
    return NUCLEOTIDES[strand] if strand.size == 1

    strand.chars.map { |c| NUCLEOTIDES[c] }.join
  end
end
