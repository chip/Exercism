class Acronym
  def self.abbreviate(phrase)
    phrase.gsub(/[-_]/, ' ').split.map { |word| word[0] }.join.upcase
  end
end
