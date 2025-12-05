class InvalidCodonError < StandardError; end

class Translation
  AMINO_ACIDS = {
    AUG: 'Methionine',
    UUU: 'Phenylalanine',
    UUC: 'Phenylalanine',
    UUA: 'Leucine',
    UUG: 'Leucine',
    UCU: 'Serine',
    UCC: 'Serine',
    UCA: 'Serine',
    UCG: 'Serine',
    UAU: 'Tyrosine',
    UAC: 'Tyrosine',
    UGU: 'Cysteine',
    UGC: 'Cysteine',
    UGG: 'Tryptophan'
  }.freeze

  STOP = %w[UAA UAG UGA].freeze

  def self.of_rna(strand)
    [] if strand.empty?

    strand.scan(/.{1,3}/)
          .take_while { |codon| !STOP.include?(codon) }
          .each_with_object([]) do |(codon, _), memo|
      raise InvalidCodonError unless AMINO_ACIDS[codon.to_sym]

      memo.push(AMINO_ACIDS[codon.to_sym])
    end
  end
end
