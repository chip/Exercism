class Alphametics
  def self.solve(puzzle)
    left, right = puzzle.gsub(/\s/, '').split('==')
    letters = puzzle.scan(/[A-Z]/).uniq
    joined_letters = letters.join

    (0..9).to_a.permutation(letters.size).each do |perm|
      mapping = Hash[letters.zip(perm)]
      # Skip leading zeros
      next if mapping[left[0]] == 0 || mapping[right[0]] == 0

      values = mapping.values.join
      left_sum = left.tr(joined_letters, values).split('+').sum(&:to_i)
      right_sum = eval(right.tr(joined_letters, values))
      return mapping if left_sum == right_sum
    end

    {}
  end
end
