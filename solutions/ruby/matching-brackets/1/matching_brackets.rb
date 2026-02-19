class Brackets
  OPEN = '[({'
  CLOSE = '])}'

  def self.paired?(text)
    brackets = []

    text.chars do |char|
      if OPEN.include?(char)
        brackets.push(char)
      elsif CLOSE.include?(char)
        return false if brackets.pop != char.tr(CLOSE, OPEN)
      end
    end

    brackets.empty?
  end
end
