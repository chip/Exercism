class Pangram
  def self.pangram?(sentence)
    ('a'..'z').all? { |c| sentence.downcase.match?(c) }
  end
end
