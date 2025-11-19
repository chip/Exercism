class SpaceAge
  attr_reader :seconds

  ORBITAL_PERIODS_IN_EARTH_YEARS = {
    'Mercury' => 0.2408467,
    'Venus' => 0.61519726,
    'Earth' => 1.0,
    'Mars' => 1.8808158,
    'Jupiter' => 11.862615,
    'Saturn' => 29.447498,
    'Uranus' => 84.016846,
    'Neptune' => 164.79132
  }.freeze

  def initialize(seconds)
    @seconds = seconds

    ORBITAL_PERIODS_IN_EARTH_YEARS.keys.map do |planet|
      self.class.define_method("on_#{planet.downcase}") do
        (seconds / (seconds_per_year * ORBITAL_PERIODS_IN_EARTH_YEARS[planet])).round(2)
      end
    end
  end

  def seconds_per_year = earth_days_per_year * 24 * 60 * 60

  def earth_days_per_year = 365.25
end
