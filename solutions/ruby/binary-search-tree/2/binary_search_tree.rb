class Bst
  attr_reader :data
  attr_accessor :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def insert(num)
    node = self

    until node.data.nil?
      target = num <= node.data ? :left : :right

      if node.public_send(target)
        node = public_send(target)
      else
        node.public_send("#{target}=", Bst.new(num))
        break
      end
    end
  end

  def each(&)
    return enum_for(:each) unless block_given?

    left.each(&) if left
    yield data
    right.each(&) if right
  end
end
