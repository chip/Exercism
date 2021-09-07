local function aliquot_sum(n)
  if n == 1 then
    return 0
  end

  local sum = 0
  -- No need to iterate beyond half-way-point of n
  local half = math.ceil(n / 2)

  for factor=1,half do
    if n % factor == 0 then
      sum = sum + factor
    end
  end
  return sum
end

local function classify(n)
  local sum = aliquot_sum(n)
  if sum == n then
    return "perfect"
  elseif sum < n then
    return "deficient"
  else
    return "abundant"
  end
end

return {
  aliquot_sum = aliquot_sum,
  classify = classify
}
