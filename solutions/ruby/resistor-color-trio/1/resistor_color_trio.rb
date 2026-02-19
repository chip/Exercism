class ResistorColorTrio
  attr_reader :value

  COLOR_BANDS = %w[black brown red orange yellow green blue violet grey white]

  def initialize(colors)
    first, second, zeros = colors.map { |s| COLOR_BANDS.index(s) }
    @value = "#{first}#{second}#{'0' * zeros}"
  end

  def label
    "Resistor value: #{ohms}"
  end

  private

  def ohms
    i = value.to_i
    if i >= 1_000_000_000
      "#{i / 1_000_000_000} gigaohms"
    elsif i >= 1_000_000
      "#{i / 1_000_000} megaohms"
    elsif i >= 1_000
      "#{i / 1_000} kiloohms"
    else
      "#{i} ohms"
    end
  end
end
