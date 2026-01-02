class Element
  attr_reader :datum
  attr_accessor :next

  def initialize(num)
    @datum = num
    @next = nil
  end
end

class SimpleLinkedList
  def initialize(args = [])
    @elements = args.inject([]) { |memo, n| memo << Element.new(n) }
  end

  def push(ele)
    @elements.push(ele)
    self
  end

  def pop
    @elements.pop
  end

  def to_a
    @elements.reverse.map(&:datum)
  end

  def reverse!
    @elements.reverse!
    self
  end
end
