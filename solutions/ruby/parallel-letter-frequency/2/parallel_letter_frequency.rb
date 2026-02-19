class ParallelLetterFrequency
  def self.count(texts)
    return {} if texts.empty?

    frequencies = Hash.new { |hsh, k| hsh[k] = 0 }
    threads = []
    texts.map do |text|
      threads << Thread.new { letter_frequency(frequencies, text) }
    end
    threads.each { |thr| thr.join }
    frequencies
  end

  def self.letter_frequency(frequencies, text)
    text.downcase.gsub(/[^\p{Letter}]/, '').chars.map do |letter|
      frequencies[letter] += 1
    end
  end
end
