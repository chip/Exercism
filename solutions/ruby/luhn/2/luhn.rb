class Luhn
  def self.valid?(str)
    return false unless valid_length?(str)

    (reduce_by_nine(str).sum % 10).zero?
  end

  def self.valid_length?(str)
    clean(str).length > 1 &&
      clean(str).length == digits_for(str).length
  end

  def self.reduce_by_nine(str)
    doubled(str).map { |n| n > 9 ? (n - 9) : n }
  end

  def self.doubled(str)
    [].tap do |a|
      digits_for(str).reverse.map(&:to_i).each_with_index do |ele, i|
        a << (i.odd? ? (ele * 2) : ele)
      end
    end
  end

  def self.clean(str)
    str.gsub(/\s+/, '')
  end

  def self.digits_for(str)
    str.scan(/\d/)
  end
end
