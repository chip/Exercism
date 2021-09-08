return function(sum)
  local sqrt = math.sqrt
  local floor = math.floor
  local triplets = {}

  local limit = sum / 2
  for a = 3, limit do
    for b = (a + 1), (sum - a) do
      local c = sqrt((a ^ 2) + (b ^ 2))
      if c == floor(c) and ((a + b + c) == sum) then
        triplets[#triplets + 1] = {a, b, c}
      end
    end
  end

  return triplets
end
