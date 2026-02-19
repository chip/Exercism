class BottleSong
  NUMBERS = %w[no one two three four five six seven eight nine ten]

  def self.recite(remaining, times)
    times.downto(1).map do
      intro = "#{bottles(remaining).capitalize} hanging on the wall,\n" * 2
      remaining -= 1
      and_if = <<~TEXT
        And if one green bottle should accidentally fall,
        There'll be #{bottles(remaining)} hanging on the wall.
      TEXT
      [intro, and_if].join
    end.join("\n")
  end

  def self.bottles(remaining)
    "#{NUMBERS[remaining]} green #{remaining == 1 ? 'bottle' : 'bottles'}"
  end
end
