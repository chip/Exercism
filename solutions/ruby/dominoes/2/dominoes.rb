class Dominoes
  def self.chain?(dominoes)
    return true if dominoes.empty?

    valid?([dominoes.shift], dominoes)
  end

  def self.valid?(chain, remaining)
    head = chain.first.first
    tail = chain.last.last

    return head == tail if remaining.empty?

    remaining.each_with_index do |dominoe, index|
      next unless dominoe.include?(tail)

      new_remaining = remaining.dup

      dominoe = new_remaining.delete_at(index)
      dominoe.reverse! if tail == dominoe.last

      chain << dominoe

      valid = valid?(chain, new_remaining)

      return true if valid
    end

    false
  end
end
