return function(array, target)
  local ceil = math.ceil
  local index = #array == 1 and 1 or ceil(#array / 2)
  local elements = #array
  while elements > 0 do
    local value = array[index]

    if target == value then
      return index
    end

    elements = #array - index

    if target < value then
      if index == 1 then
        return -1
      end
      index = ceil(index / 2)
    else
      index = index + ceil(elements / 2)
    end
  end
  return -1
end
