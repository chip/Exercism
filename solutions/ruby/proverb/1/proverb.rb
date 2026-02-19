class Proverb
  attr_reader :words

  def initialize(*words, qualifier: nil)
    @words = words
    @qualifier = qualifier
    @first_word = words.first || ''
  end

  def to_s
    return '' if words.empty?

    i = 0
    words.each_with_object([]) do |word, proverbs|
      proverbs << "For want of a #{words[i]} the #{words[i + 1]} was lost." unless words[i + 1].nil?
      i += 1
    end.push("And all for the want of a #{ending}.").join("\n")
  end

  private

  def ending
    @qualifier.nil? ? @first_word : "#{@qualifier} #{@first_word}"
  end
end
