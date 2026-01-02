class Element
  attr_reader :datum
  attr_accessor :next

  def initialize(datum)
    @datum = datum
  end
end

class SimpleLinkedList < Array
  def initialize(arr = [])
    super(arr.map { |e| Element.new(e) })
  end

  def to_a
    reverse.map(&:datum)
  end
end
