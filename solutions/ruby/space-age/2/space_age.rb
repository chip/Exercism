class SpaceAge
  attr_reader :seconds

  ORBITAL_PERIODS_IN_EARTH_YEARS = {
    mercury: 0.2408467,
    venus: 0.61519726,
    earth: 1.0,
    mars: 1.8808158,
    jupiter: 11.862615,
    saturn: 29.447498,
    uranus: 84.016846,
    neptune: 164.79132
  }.freeze

  def initialize(seconds)
    @seconds = seconds

    ORBITAL_PERIODS_IN_EARTH_YEARS.map do |planet, orbital_period|
      self.class.define_method("on_#{planet}") do
        (seconds / (seconds_per_year * orbital_period)).round(2)
      end
    end
  end

  def seconds_per_year = earth_days_per_year * 24 * 60 * 60

  def earth_days_per_year = 365.25
end
