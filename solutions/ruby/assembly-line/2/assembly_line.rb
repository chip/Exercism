class AssemblyLine
  CARS_PER_HOUR = 221
  MINUTES_PER_HOUR = 60

  def initialize(speed)
    @speed = speed
  end

  def production_rate_per_hour
    (@speed * CARS_PER_HOUR * error_rate)
  end

  def working_items_per_minute
    (production_rate_per_hour / MINUTES_PER_HOUR).to_i
  end

  private

  def error_rate
    case @speed
    when 10 then 0.77
    when 9 then 0.8
    when 5..8 then 0.9
    else 1
    end
  end
end
