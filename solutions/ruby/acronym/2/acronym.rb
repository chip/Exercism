class Acronym
  def self.abbreviate(phrase)
    phrase.gsub(/[-_]/, ' ').gsub(/['\\]/, '').scan(/\b\w/).join.upcase
  end
end
