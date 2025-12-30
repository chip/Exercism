class Alphametics
  def self.solve(puzzle)
    equation = puzzle.downcase
    letters = equation.scan(/\w/).uniq
    not_zero_expr = equation.scan(/\b(.)\w/).flatten.uniq.map { "#{it} != 0 && " }.join

    math_expr = equation.gsub(/\w+/) do |word|
      "(#{word.chars.reverse.map.with_index { |char, i| "#{char}*#{10**i}" }.join '+'})"
    end

    arguments = letters.join(',').downcase
    checker = eval "-> #{arguments} { #{not_zero_expr}#{math_expr} }"
    (0..9).to_a.permutation(letters.size) do |numbers|
      return letters.map(&:upcase).zip(numbers).to_h if checker[*numbers]
    end
    {}
  end
end
