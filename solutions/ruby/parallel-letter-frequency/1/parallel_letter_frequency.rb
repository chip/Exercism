class ParallelLetterFrequency
  def self.count(texts)
    return {} if texts.empty?

    texts.join.downcase.gsub(/[\d\s[[:punct:]]]/, '').chars.tally
  end
end
