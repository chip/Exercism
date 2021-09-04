return function(array, target)
  local size = #array
  local first = array[1]
  local last = array[size]

  if size == 0 or (size == 1 and array[1] ~= target) or target > array[size] or target < array[1] then
    return -1
  end

  if first == target then
    return 1
  end

  if last == target then
    return size
  end

  if size == 1 and first == target then
    return 1
  end

  local index = math.ceil(size / 2)
  local left = 1
  local right = size

  while left < right do
    if array[index] == target then
      break
    elseif array[index] > target then
      index = math.ceil(index / 2)
      right = index
    else
      index = math.ceil(index + ((size - index) / 2))
      left = index
    end
  end

  return index
end
