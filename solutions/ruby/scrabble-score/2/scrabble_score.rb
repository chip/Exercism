class Scrabble
  SCORES = {
    'AEIOULNRST' => 1,
    'DG' => 2,
    'BCMP' => 3,
    'FHVWY' => 4,
    'K' => 5,
    'JX' => 8,
    'QZ' => 10
  }.freeze

  LETTER_SCORES = SCORES.each_with_object({}) do |(letters, value), map|
    letters.each_char { |ch| map[ch] = value }
  end.freeze

  def initialize(word)
    @word = word
  end

  def score
    @word.upcase.scan(/\w/).map { |c| LETTER_SCORES[c] }.sum
  end
end
