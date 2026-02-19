class Anagram
  attr_reader :target

  def initialize(target)
    @target = target
  end

  def match(candidates)
    candidates
      .reject { |e| e.upcase == target.upcase }
      .map { |word| word_tally(word) }
      .compact
  end

  private

  def word_tally(word)
    word if word.upcase.chars.tally == target.upcase.chars.tally
  end
end
