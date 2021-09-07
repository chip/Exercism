return function(sum)
  local triplets = {}

  local limit = sum / 2
  local a = 3
  while a < limit do
    local b = a + 1
    local b_limit = sum - a
    while b < b_limit do
      local c_squared = (a ^ 2) + (b ^ 2)
      local c_root  = math.sqrt(c_squared)
      local c = math.floor(c_root)
      -- test that square root of c is an integer
      if c == c_root and (a + b + c == sum) then
        table.insert(triplets, {a, b ,c})
      end
      b = b + 1
    end
    a = a + 1
  end

  return triplets
end
