class Proverb
  attr_reader :words, :qualifier

  def initialize(*words, qualifier: '')
    @words = words
    @qualifier = qualifier
  end

  def to_s
    return '' if words.empty?

    words.each_cons(2)
         .map { |a, b| "For want of a #{a} the #{b} was lost." }
         .push("And all for the want of a #{qualifier} #{words.first}.".squeeze(' '))
         .join("\n")
  end
end
