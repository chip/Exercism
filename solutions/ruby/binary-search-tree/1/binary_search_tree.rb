class Bst
  attr_reader :data
  attr_accessor :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def insert(num)
    ele = Bst.new(num)
    node = self

    until node.data.nil?
      if num <= node.data
        if node.left
          node = node.left
        else
          node.left = ele
          break
        end
      elsif node.right
        node = node.right
      else
        node.right = ele
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
