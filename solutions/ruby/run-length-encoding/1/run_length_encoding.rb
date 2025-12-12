class RunLengthEncoding
  def self.encode(text)
    return '' if text.empty?

    text.scan(/((.)\2*)/).map do |full, char|
      full.length > 1 ? "#{full.size}#{char}" : char
    end.join
  end

  def self.decode(text)
    return '' if text.empty?

    text.scan(/(\d*)([A-Za-z ]{1})/).map do |digits, char|
      digits.to_i.positive? ? char * digits.to_i : char
    end.join
  end
end
