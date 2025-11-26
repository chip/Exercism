module ArmstrongNumbers
  def self.include?(number)
    number.to_s.split('').map(&:to_i).map { |i| i**number.to_s.size }.sum == number
  end
end
