class BinarySearch
  def initialize(numbers)
    @numbers = numbers.sort
    @position = 0
  end

  def search_for(target)
    search(target, @numbers)
  end

  private

  def search(target, numbers)
    return if numbers && numbers.empty?

    index = (numbers.size / 2).floor
    middle = numbers[index]

    if middle == target
      @position += index
      @position
    elsif middle > target
      search(target, numbers[...index])
    else
      return if numbers.size == 1

      @position += index
      search(target, numbers[index..])
    end
  end
end
