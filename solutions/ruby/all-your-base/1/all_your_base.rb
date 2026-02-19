class BaseConverter
  def self.convert(*args)
    input_base, digits, output_base = args

    raise ArgumentError if invalid_args(*args)

    value = digits.inject(0) { |memo, d| (memo * input_base) + d }

    remainders = []
    while value > 0
      quotient, remainder = value.divmod(output_base)
      remainders << remainder
      value = quotient.floor
    end
    remainders.empty? ? [0] : remainders.reverse
  end

  def self.invalid_args(*args)
    input_base, digits, output_base = args

    raise ArgumentError if input_base <= 1 ||
                           output_base <= 1 ||
                           digits.any?(&:negative?) ||
                           digits.any? { |d| !(0...input_base).include?(d) }
  end
end
