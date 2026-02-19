class RunLengthEncoding
  def self.encode(text)
    text.gsub(/(.)\1+/) { |m| "#{m.size}#{m[0]}" }
  end

  def self.decode(text)
    text.gsub(/\d+./) { |m| m[-1] * m.to_i }
  end
end
