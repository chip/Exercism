class Transpose
  def self.transpose(text)
    lines = text.split("\n")
    max = lines.map(&:size).max
    lines.map { |s| (s << ('#' * (max - s.size))) }
         .map(&:chars)
         .transpose
         .map(&:join)
         .map { |s| s.gsub(/\#+$/, '').gsub('#', ' ') }
         .join("\n")
  end
end
