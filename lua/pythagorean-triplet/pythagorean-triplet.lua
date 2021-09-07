return function(sum)
  local triplets = {}

  for a=2,sum do
    local b_limit = sum - a
    for b=(a+1),b_limit do
      local ab = (a ^ 2) + (b ^ 2)
      local sqrt_c = math.sqrt(ab)
      if math.floor(sqrt_c) == sqrt_c then
        for c=(b+1),sqrt_c do
          local c2 = c ^ 2
          if (ab == c2) and (a < b and b < c) and (a + b + c == sum) then
            table.insert(triplets, {a, b ,c})
          end
        end
      end
    end
  end

  return triplets
end
