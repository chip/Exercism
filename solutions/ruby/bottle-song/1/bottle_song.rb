class BottleSong
  NUMBERS = %w[Zero One Two Three Four Five Six Seven Eight Nine Ten]

  def self.recite(remaining, times)
    times.downto(1).map do
      before = bottles(remaining)
      remaining -= 1
      after = bottles(remaining)

      <<~TEXT
        #{before} hanging on the wall,
        #{before} hanging on the wall,
        And if one green bottle should accidentally fall,
        There'll be #{after.downcase} hanging on the wall.
      TEXT
    end.join("\n")
  end

  def self.bottles(remaining)
    "#{remaining.zero? ? 'no' : NUMBERS[remaining]} green #{remaining == 1 ? 'bottle' : 'bottles'}"
  end
end
