class AssemblyLine
  CARS_PER_HOUR = 221
  MINUTES_PER_HOUR = 60

  def initialize(speed)
    @speed = speed
  end

  def production_rate_per_hour
    (@speed * CARS_PER_HOUR * error_rate).to_f
  end

  def working_items_per_minute
    (production_rate_per_hour / MINUTES_PER_HOUR).floor
  end

  private

  def error_rate
    if @speed == 10
      0.77
    elsif @speed == 9
      0.8
    elsif (5..8).to_a.include?(@speed)
      0.9
    else
      1
    end
  end
end
