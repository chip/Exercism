class Isogram
  def self.isogram?(input)
    input.downcase.scan(/\w/).tally.values.none? { |n| n > 1 }
  end
end
