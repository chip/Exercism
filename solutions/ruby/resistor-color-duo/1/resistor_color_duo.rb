class ResistorColorDuo
  BAND_COLORS = %w[black brown red orange yellow green blue violet grey white].freeze

  def self.value(colors)
    one, two, = colors
    Integer([BAND_COLORS.index(one), BAND_COLORS.index(two)].join)
  end
end
