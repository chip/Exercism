class Grains
  VALID_RANGE = (1..64)

  def self.square(number)
    raise ArgumentError unless VALID_RANGE.include? number

    2**(number - 1)
  end

  def self.total
    VALID_RANGE.map(&Grains.method(:square)).sum
  end
end
