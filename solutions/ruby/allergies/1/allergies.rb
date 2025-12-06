class Allergies
  MAPPING = {
    1 => 'eggs',
    2 => 'peanuts',
    4 => 'shellfish',
    8 => 'strawberries',
    16 => 'tomatoes',
    32 => 'chocolate',
    64 => 'pollen',
    128 => 'cats'
  }.freeze

  def initialize(num)
    @num = num %= 256
  end

  def list
    nil unless @num > 0

    num = @num
    candidates.each_with_object([]) do |k, a|
      quotient, remainder = num.divmod(k)
      a.push(MAPPING[k]) if quotient == 1
      num -= k if num >= k
    end.reverse
  end

  def allergic_to?(allergy)
    list.include?(allergy)
  end

  private

  def candidates
    MAPPING.keys.reverse.select { |k| @num >= k }
  end
end
