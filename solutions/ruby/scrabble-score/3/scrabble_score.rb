class Scrabble
  LETTER_SCORES = {
    /[AEIOULNRST]/ => 1,
    /[DG]/ => 2,
    /[BCMP]/ => 3,
    /[FHVWY]/ => 4,
    /[K]/ => 5,
    /[JX]/ => 8,
    /[QZ]/ => 10
  }.freeze

  def initialize(word)
    @word = word.upcase
  end

  def score
    LETTER_SCORES.inject(0) do |word_score, (letters, value)|
      word_score + (@word.scan(letters).count * value)
    end
  end
end
