class WordProblem
  attr_reader :sanitized

  OPS = { plus: :+, minus: :-, divided: :/, multiplied: :* }.freeze
  DIGITS = /^\d+$/

  def initialize(question)
    @sanitized = question.gsub('What is ', '').gsub(' by', '').chop
  end

  def answer
    return sanitized.to_i if sanitized.match(DIGITS)

    raise ArgumentError unless valid_tokens?

    sum = tokens.shift
    sum = sum.public_send(tokens.shift, tokens.shift) until tokens.empty?
    sum
  end

  private

  def tokens
    @tokens ||= sanitized.split.map.with_index do |e, i|
      i.even? ? e.to_i : OPS.fetch(e.to_sym, nil)
    end
  end

  def valid_tokens?
    return false unless tokens.size.odd? &&
                        tokens.select.with_index { |_, i| i.even? }.all?(&:integer?) &&
                        tokens.select.with_index { |_, i| i.odd? }.none?(&:nil?)

    true
  end
end
