class Clock
  attr_reader :hour, :minute

  def initialize(hour: 0, minute: 0)
    hour += minute / 60
    @hour = hour % 24
    @minute = minute % 60
  end

  def to_s
    format('%<hour>02d:%<minute>02d', hour:, minute:)
  end

  def +(other)
    Clock.new(hour: hour + other.hour, minute: minute + other.minute)
  end

  def -(other)
    Clock.new(hour: hour - other.hour, minute: minute - other.minute)
  end

  def ==(other)
    hour == other.hour && minute == other.minute
  end
end
