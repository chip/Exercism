class ParallelLetterFrequency
  def self.count(texts)
    return {} if texts.empty?

    ractors = texts.map(&ParallelLetterFrequency.method(:letter_frequency))
    ractors.each_with_object(Hash.new(0)) do |ractor, count|
      ractor.each { |k, v| count[k] += v }
    end
  end

  def self.letter_frequency(text)
    text.downcase.gsub(/[^\p{Letter}]/, '').chars.tally
  end
end
