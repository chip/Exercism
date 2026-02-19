class Phrase
  def initialize(args)
    @str = args.downcase
               .scan(/\b[\w']+\b/)
    # .gsub(/[:.!&@$%^]/, '') # remove special characters
    # .gsub(',', ' ')         # replace commas with spaces
    # .gsub(/(?<=[\s])'/, '') # remove apostrophes when preceded by a space
    # .gsub(/'(?=[\s])/, '')  # remove apostrophes when succeeded by a space
    # .sub(/^'/, '')          # remove apostrophes at beginning of string
    # .sub(/'$/, '')          # remove apostrophes at end of string
  end

  def word_count
    @str.split.tally
  end
end
