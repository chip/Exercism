class BinarySearch
  def initialize(array)
    @array = array
  end

  def search_for(number)
    min = 0
    max = @array.size - 1

    while min <= max
      mid = (min + max) / 2
      return mid if @array[mid] == number

      @array[mid] < number ? min = mid + 1 : max = mid - 1
    end
  end
end
