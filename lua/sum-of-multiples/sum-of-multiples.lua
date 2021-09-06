return function(numbers)
  local multiples = {}

  local function reduce(list)
    local sum = 0

    for n,_ in pairs(list) do
      sum = sum + n
    end

    return sum
  end

  local function to(limit)
    for i=1,#numbers do
      local num = numbers[i]
      local current = num

      while current < limit do
        if not multiples[current] then
          multiples[current] = true
        end
        current = current + num
      end
    end

    return reduce(multiples)
  end

  return { to = to }
end
