class ETL
  def self.transform(input)
    input.each_with_object({}) do |(points, letters), memo|
      letters.map { |letter| memo[letter.downcase] = points }
    end
  end
end
