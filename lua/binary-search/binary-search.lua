return function(array, target)
  local floor = math.floor
  local ceil = math.ceil
  local found = false

  local index = #array == 1 and 1 or floor(#array / 2)
  print("target:"..target)
  local elements = #array
  while elements > 0 do
    local value = array[index]
    print("index: ", index, " value: ", value, " elements: ", elements)
    if value == nil then
      elements = 0
      break
    end

    if target == value then
      found = true
      elements = 0
      break
    end

    if target < value then
      -- target = 2
      -- local array = TracedArray{ 6, 67, 123, 345, 456, 457, 490, 2002, 54321, 54322 }
      if index == 1 then
        elements = 0
        break
      end
      elements = #array - index
      index = ceil(index / 2)
    else
      -- print("else", index)
      elements = #array - index
      index = index + ceil((#array - index) / 2)
    end

  end
  if found then
    return index
  else
    return -1
  end
end
