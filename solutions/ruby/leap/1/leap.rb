class Year
  def self.leap?(year)
    return false unless (year % 4).zero?
    return true unless (year % 100).zero?

    (year % 400).zero?
  end
end
