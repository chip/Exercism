module ArmstrongNumbers
  def self.include?(number)
    number.digits.sum { |i| i**number.digits.size } == number
  end
end
