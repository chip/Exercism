class Luhn
  def self.valid?(str)
    return false unless valid_length?(str)

    total = double_every_second_digit(str).map do |n|
      n > 9 ? (n - 9) : n
    end.sum
    (total % 10).zero?
  end

  def self.valid_length?(str)
    without_spaces(str).length > 1 &&
      without_spaces(str).length == digits_for(str).length
  end

  def self.double_every_second_digit(str)
    doubled = []
    digits_for(str).reverse.map(&:to_i).each_with_index do |ele, i|
      doubled << (i.odd? ? (ele * 2) : ele)
    end
    doubled
  end

  def self.without_spaces(str)
    str.gsub(/\s+/, '')
  end

  def self.digits_for(str)
    str.scan(/\d/)
  end
end
