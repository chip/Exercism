class BottleSong
  NUMBERS = %w[no one two three four five six seven eight nine ten]

  def self.recite(remaining, times)
    times.downto(1).map do
      text = ["#{bottles(remaining).capitalize} hanging on the wall,"] * 2
      text << 'And if one green bottle should accidentally fall,'
      remaining -= 1
      text << "There'll be #{bottles(remaining)} hanging on the wall."
      text.join("\n").concat("\n")
    end.join("\n")
  end

  def self.bottles(n)
    format('%s green bottle%s', NUMBERS[n], n == 1 ? '' : 's')
  end
end
