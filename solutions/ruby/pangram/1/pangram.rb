class Pangram
  def self.pangram?(sentence)
    ('a'..'z').map { |c| sentence.downcase.match?(c) }.all?
  end
end
