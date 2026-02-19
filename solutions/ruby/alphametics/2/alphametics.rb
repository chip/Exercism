class Alphametics
  def self.solve(puzzle)
    left, right = puzzle.gsub(/\s/, '').split('==')
    letters = puzzle.scan(/[A-Z]/).uniq
    joined_letters = letters.join

    (0..9).to_a.permutation(letters.size).each do |perm|
      mapping = letters.zip(perm).to_h
      next if mapping[left[0]] == 0 || mapping[right[0]] == 0

      left_sum = left.tr(joined_letters, mapping.values.join).split('+').sum(&:to_i)
      right_sum = right.tr(joined_letters, mapping.values.join).to_i

      return mapping if left_sum == right_sum
    end

    {}
  end
end
